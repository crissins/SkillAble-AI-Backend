import os
import json
import logging
import tempfile
import azure.functions as func
from azure.ai.formrecognizer import DocumentAnalysisClient
from azure.core.credentials import AzureKeyCredential
from azure.storage.blob import BlobServiceClient
import azure.cognitiveservices.speech as speechsdk
from openai import AzureOpenAI
from dotenv import load_dotenv
load_dotenv()

# Initialize the Azure Function App
app = func.FunctionApp()

# Initialize settings
connection_string = os.environ["AzureWebJobsStorage"]
blob_service_client = BlobServiceClient.from_connection_string(connection_string)

document_intelligence_endpoint = os.environ["DOCUMENT_INTELLIGENCE_ENDPOINT"]
document_intelligence_key = os.environ["DOCUMENT_INTELLIGENCE_KEY"]

# Initialize Azure OpenAI client with API Key Authentication
api_key = os.environ["OPENAI_API_KEY"]  # Get your API key from environment variables or settings
api_version = "2024-12-01-preview"
azure_endpoint = "https://unitedcoachaih1164957527.cognitiveservices.azure.com" # Base endpoint without deployment

openai_client = AzureOpenAI(
    api_version=api_version,
    azure_endpoint=azure_endpoint,
    api_key=api_key,
)

speech_key = os.environ["SPEECH_KEY"]
speech_region = os.environ["SPEECH_REGION"]

# Function 1: PDF Processing with Document Intelligence - SIMPLIFIED
@app.function_name("ProcessPDF")
@app.blob_trigger(arg_name="blob", 
                 path="pdfs/{name}.pdf",
                 connection="AzureWebJobsStorage")
def process_pdf(blob: func.InputStream):
    logging.info(f"Python blob trigger function processed blob: {blob.name}")
    
    try:
        # Save the blob to a temporary file
        temp_file_path = tempfile.mktemp(suffix='.pdf')
        with open(temp_file_path, 'wb') as temp_file:
            temp_file.write(blob.read())
        
        # Process the PDF using Document Intelligence
        document_analysis_client = DocumentAnalysisClient(
            endpoint=document_intelligence_endpoint, 
            credential=AzureKeyCredential(document_intelligence_key)
        )
        
        with open(temp_file_path, "rb") as file:
            poller = document_analysis_client.begin_analyze_document("prebuilt-document", file)
        result = poller.result()
        
        # SIMPLIFIED: Just extract the content as plain text
        document_content = result.content
        
        # Upload to processed-data container as plain text, not JSON
        file_name = os.path.basename(blob.name).replace('.pdf', '.txt')
        container_name = "processed-data"
        create_container_if_not_exists(container_name)
        
        blob_client = blob_service_client.get_blob_client(
            container=container_name,
            blob=file_name
        )
        blob_client.upload_blob(document_content, overwrite=True)
        
        logging.info(f"PDF {blob.name} processed and content uploaded to {file_name}")
        
    except Exception as e:
        logging.error(f"Error processing PDF: {str(e)}")
    finally:
        # Clean up temporary file
        if os.path.exists(temp_file_path):
            os.remove(temp_file_path)

@app.function_name("AnalyzeWithOpenAI")
@app.blob_trigger(arg_name="blob", 
                 path="processed-data/{name}.txt",
                 connection="AzureWebJobsStorage")
def analyze_with_openai(blob: func.InputStream):
    logging.info(f"Processing content with OpenAI: {blob.name}")
    
    try:
        # Read the text content directly (no JSON parsing)
        document_content = blob.read().decode('utf-8')
        logging.info(f"Successfully read document content, length: {len(document_content)} characters")
        
        # Create a prompt for GPT-4o mini
        system_prompt = """
        You are an expert document analyzer. Your task is to:
        1. Summarize the key information from the document
        2. Extract important points, facts, and insights
        3. Organize the information in a clear, structured way
        4. Format your output as a JSON with the following structure:
        {
            "title": "Document title if found, or 'Unknown Document'",
            "summary": "A concise summary of the document (100-200 words)",
            "key_points": ["Point 1", "Point 2", "..."],
            "entities": [{"name": "Entity name", "type": "Type of entity (person, organization, date, etc.)"}],
            "sentiment": "Overall sentiment of the document (positive, negative, neutral)"
        }
        """
        
        # Use the proper API configuration for Azure OpenAI
        api_key = os.environ["OPENAI_API_KEY"]
        api_version = "2025-01-01"
        deployment_name = "gpt-4o-mini"
        
        # IMPORTANT: The endpoint needs to include the deployment and operation in Azure OpenAI
        azure_endpoint = "https://unitedcoachaih1164957527.cognitiveservices.azure.com"

        # Log authentication details (securely)
        logging.info(f"Using API key prefix: {api_key[:5]}...")
        logging.info(f"Endpoint: {azure_endpoint}")
        logging.info(f"API Version: {api_version}")
        logging.info(f"Deployment: {deployment_name}")

        # Initialize the Azure OpenAI client
        client = AzureOpenAI(
            api_version=api_version,
            azure_endpoint=azure_endpoint,
            api_key=api_key,
        )

        # Call OpenAI to analyze the content
        logging.info(f"Sending request to OpenAI with model: {deployment}")
        
        # Send content for analysis, limiting if necessary for testing
        content_limit = 4000 if len(document_content) > 4000 else len(document_content)
        truncated_content = document_content[:content_limit]
        if content_limit < len(document_content):
            truncated_content += "...[content truncated for processing]"
        
        # This is where the error occurs - the model parameter should match your deployment name
        response = client.chat.completions.create(
            model="gpt-4o-mini",  # This should match your deployment name exactly
            messages=[
                {"role": "system", "content": system_prompt},
                {"role": "user", "content": f"Analyze this document content:\n\n{truncated_content}"}
            ],
            temperature=0.3,
            max_tokens=4096
        )
        
        # Extract the response
        gpt_analysis = response.choices[0].message.content
        logging.info(f"OpenAI response received, length: {len(gpt_analysis)} characters")
        
        # Ensure we have valid JSON
        try:
            # In case the response is not already JSON-formatted
            if not gpt_analysis.strip().startswith('{'):
                # Try to extract JSON if it's wrapped in code blocks
                if "```json" in gpt_analysis:
                    json_start = gpt_analysis.find("```json") + 7
                    json_end = gpt_analysis.find("```", json_start)
                    gpt_analysis = gpt_analysis[json_start:json_end].strip()
                else:
                    # Just extract the analysis without worrying about JSON format
                    analysis_output = {
                        "title": "Unknown Document",
                        "summary": gpt_analysis[:200] + "...",
                        "key_points": ["Automatic extraction failed"],
                        "entities": [],
                        "sentiment": "neutral"
                    }
                    gpt_analysis = json.dumps(analysis_output)
            
            # Validate JSON
            json.loads(gpt_analysis)
            logging.info("Successfully validated JSON response")
            
        except json.JSONDecodeError as json_error:
            logging.error(f"Error formatting OpenAI response as JSON: {str(json_error)}")
            # If not valid JSON, create a simple JSON structure
            analysis_output = {
                "title": "Unknown Document",
                "summary": gpt_analysis[:200] + "...",
                "key_points": ["Automatic JSON formatting failed"],
                "entities": [],
                "sentiment": "neutral",
                "raw_analysis": gpt_analysis
            }
            gpt_analysis = json.dumps(analysis_output)
        
        # Upload to gpt-data container
        file_name = os.path.basename(blob.name).replace('.txt', '.json')
        container_name = "gpt-data"
        create_container_if_not_exists(container_name)
        
        blob_client = blob_service_client.get_blob_client(
            container=container_name,
            blob=file_name
        )
        blob_client.upload_blob(gpt_analysis, overwrite=True)
        
        logging.info(f"Text {blob.name} analyzed with OpenAI and results uploaded to {container_name}/{file_name}")
        
    except Exception as e:
        import traceback
        logging.error(f"Error processing with OpenAI: {str(e)}")
        logging.error(f"Traceback: {traceback.format_exc()}")

# Function 3: Convert to Speech
@app.function_name("ConvertToSpeech")
@app.blob_trigger(arg_name="blob", 
                 path="gpt-data/{name}.json",
                 connection="AzureWebJobsStorage")
def convert_to_speech(blob: func.InputStream):
    logging.info(f"Converting to speech: {blob.name}")
    
    try:
        # Read the JSON content
        json_content = blob.read().decode('utf-8')
        analysis = json.loads(json_content)
        
        # Extract the summary from the analysis
        summary = analysis.get("summary", "No summary available.")
        title = analysis.get("title", "Unknown Document")
        
        # Prepare text for speech synthesis
        speech_text = f"Document Title: {title}. Summary: {summary}"
        
        # Add key points if available
        key_points = analysis.get("key_points", [])
        if key_points:
            speech_text += " Key points: "
            for i, point in enumerate(key_points):
                speech_text += f" Point {i+1}: {point}."
        
        # Initialize speech synthesizer
        speech_config = speechsdk.SpeechConfig(subscription=speech_key, region=speech_region)
        speech_config.speech_synthesis_voice_name = "en-US-JennyNeural"  # You can change this to your preferred voice
        
        # Create a temporary file for the audio output
        temp_audio_file = tempfile.mktemp(suffix='.wav')
        audio_config = speechsdk.audio.AudioOutputConfig(filename=temp_audio_file)
        
        # Create the speech synthesizer
        speech_synthesizer = speechsdk.SpeechSynthesizer(speech_config=speech_config, audio_config=audio_config)
        
        # Synthesize text to speech
        result = speech_synthesizer.speak_text_async(speech_text).get()
        
        # Check the result
        if result.reason == speechsdk.ResultReason.SynthesizingAudioCompleted:
            logging.info("Speech synthesis completed for text [{}]".format(speech_text))
            
            # Upload the audio file to the audio-data container
            file_name = os.path.basename(blob.name).replace('.json', '.wav')
            container_name = "audio-data"
            create_container_if_not_exists(container_name)
            
            # Read the audio file and upload it
            with open(temp_audio_file, "rb") as audio_file:
                blob_client = blob_service_client.get_blob_client(
                    container=container_name,
                    blob=file_name
                )
                blob_client.upload_blob(audio_file.read(), overwrite=True)
            
            logging.info(f"Audio file uploaded as {file_name}")
            
        elif result.reason == speechsdk.ResultReason.Canceled:
            cancellation_details = result.cancellation_details
            logging.error(f"Speech synthesis canceled: {cancellation_details.reason}")
            if cancellation_details.reason == speechsdk.CancellationReason.Error:
                logging.error(f"Error details: {cancellation_details.error_details}")
    
    except Exception as e:
        logging.error(f"Error converting to speech: {str(e)}")
    finally:
        # Clean up the temporary audio file
        if 'temp_audio_file' in locals() and os.path.exists(temp_audio_file):
            os.remove(temp_audio_file)

# Helper function to create a container if it doesn't exist
def create_container_if_not_exists(container_name):
    try:
        container_client = blob_service_client.get_container_client(container_name)
        if not container_client.exists():
            container_client.create_container()
            logging.info(f"Container '{container_name}' created")
    except Exception as e:
        logging.error(f"Error creating container {container_name}: {str(e)}")