import os
import json
import logging
import tempfile
import azure.functions as func
from azure.ai.formrecognizer import DocumentAnalysisClient
from azure.core.credentials import AzureKeyCredential
from azure.storage.blob import BlobServiceClient
import azure.cognitiveservices.speech as speechsdk
import openai
from dotenv import load_dotenv
load_dotenv()

# Initialize the Azure Function App
app = func.FunctionApp()

# Initialize the Durable Functions Blueprint
bp = func.Blueprint()

# Storage connection string
connection_string = os.environ["AzureWebJobsStorage"]
blob_service_client = BlobServiceClient.from_connection_string(connection_string)

# Document Intelligence (Form Recognizer) settings
document_intelligence_endpoint = os.environ["DOCUMENT_INTELLIGENCE_ENDPOINT"]
document_intelligence_key = os.environ["DOCUMENT_INTELLIGENCE_KEY"]

# OpenAI settings
openai.api_type = "azure"
openai.api_base = os.environ["OPENAI_API_ENDPOINT"]
openai.api_version = os.environ["OPENAI_API_VERSION"]
openai.api_key = os.environ["OPENAI_API_KEY"]

# Speech settings
speech_key = os.environ["SPEECH_KEY"]
speech_region = os.environ["SPEECH_REGION"]

# Function 1: PDF Processing with Document Intelligence
@bp.blob_trigger(arg_name="blob", 
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
        
        # Convert the result to JSON
        extracted_data = {
            "content": result.content,
            "pages": len(result.pages),
            "tables": [
                {
                    "row_count": table.row_count,
                    "column_count": table.column_count,
                    "cells": [
                        {
                            "text": cell.content,
                            "row_index": cell.row_index,
                            "column_index": cell.column_index
                        } for cell in table.cells
                    ]
                } for table in result.tables
            ],
            "key_value_pairs": [
                {
                    "key": kv.key.content if kv.key else "",
                    "value": kv.value.content if kv.value else ""
                } for kv in result.key_value_pairs
            ]
        }
        
        json_data = json.dumps(extracted_data)
        
        # Upload to processed-data container
        file_name = os.path.basename(blob.name).replace('.pdf', '.json')
        container_name = "processed-data"
        create_container_if_not_exists(container_name)
        
        blob_client = blob_service_client.get_blob_client(
            container=container_name,
            blob=file_name
        )
        blob_client.upload_blob(json_data, overwrite=True)
        
        logging.info(f"PDF {blob.name} processed and JSON uploaded to {file_name}")
        
    except Exception as e:
        logging.error(f"Error processing PDF: {str(e)}")
    finally:
        # Clean up temporary file
        if os.path.exists(temp_file_path):
            os.remove(temp_file_path)

# Function 2: Process JSON with Azure OpenAI
@bp.blob_trigger(arg_name="blob", 
                path="processed-data/{name}.json",
                connection="AzureWebJobsStorage")
def analyze_with_openai(blob: func.InputStream):
    logging.info(f"Processing JSON with OpenAI: {blob.name}")
    
    try:
        # Read the JSON content
        json_content = blob.read().decode('utf-8')
        data = json.loads(json_content)
        
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
        
        # Extract the text content from the document data
        document_content = data.get("content", "")
        
        # Add key-value pairs info if present
        if "key_value_pairs" in data and data["key_value_pairs"]:
            document_content += "\n\nKey-Value pairs found in the document:\n"
            for kv in data["key_value_pairs"]:
                document_content += f"{kv['key']}: {kv['value']}\n"
        
        # Call OpenAI to analyze the content
        response = openai.ChatCompletion.create(
            engine="gpt-4o-mini",  # Adjust as needed for your deployment
            messages=[
                {"role": "system", "content": system_prompt},
                {"role": "user", "content": f"Analyze this document content:\n\n{document_content}"}
            ],
            temperature=0.3,
            max_tokens=1000
        )
        
        # Extract the response
        gpt_analysis = response.choices[0].message.content
        
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
        except json.JSONDecodeError:
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
        file_name = os.path.basename(blob.name)
        container_name = "gpt-data"
        create_container_if_not_exists(container_name)
        
        blob_client = blob_service_client.get_blob_client(
            container=container_name,
            blob=file_name
        )
        blob_client.upload_blob(gpt_analysis, overwrite=True)
        
        logging.info(f"JSON {blob.name} analyzed with OpenAI and results uploaded")
        
    except Exception as e:
        logging.error(f"Error processing with OpenAI: {str(e)}")

# Function 3: Convert to Speech
@bp.blob_trigger(arg_name="blob", 
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

# Register the blueprint with the function app
app.register_functions(bp)