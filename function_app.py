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
import re
import time
from azure.communication.email import EmailClient
from azure.core.credentials import AzureKeyCredential
import base64
load_dotenv()

# Initialize the Azure Function App
app = func.FunctionApp()

# Initialize settings
connection_string = os.environ["AzureWebJobsStorage"]
blob_service_client = BlobServiceClient.from_connection_string(connection_string)

document_intelligence_endpoint = os.environ["DOCUMENT_INTELLIGENCE_ENDPOINT"]
document_intelligence_key = os.environ["DOCUMENT_INTELLIGENCE_KEY"]

# Initialize Azure OpenAI client with API Key Authentication
api_key = os.environ["OPENAI_API_KEY"]
api_version = os.environ["OPENAI_API_VERSION"]
azure_endpoint = os.environ["OPENAI_API_ENDPOINT"].split("/openai")[0]  # Get base endpoint

speech_key = os.environ["SPEECH_KEY"]
speech_region = os.environ["SPEECH_REGION"]

# Email configuration for Azure Communication Services Email
email_connection_string = os.environ.get("EMAIL_CONNECTION_STRING", "")
email_sender = os.environ.get("EMAIL_SENDER", "")

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

# Function 2: Process text content with Azure OpenAI
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
        
        # Create an enhanced prompt for GPT-4o mini with specialized job coach requirements
        system_prompt = """
        You are an expert document analyzer supporting job coaches who work with people with disabilities. Your specialized task is to transform training materials and employment documents into accessible formats that help coaches better support their clients. 
        
        Analyze the document thoroughly with a focus on vocational training concepts, workplace accommodations, and employment skills. Then provide the following outputs:

        1. A comprehensive summary highlighting key job training aspects, employment skills, and support strategies
        2. A speech-optimized version specifically designed for job coaches to use with audio learning clients
        3. A braille-optimized version structured for tactile reading without losing essential job training details
        4. Format your output as a JSON with the following structure:

        {
            "title": "Document title if found, or 'Unknown Document'",
            "summary": "A comprehensive analysis highlighting vocational training concepts, workplace accommodations, and employment skills (400-600 words)",
            "summarization_for_speech": "A conversational version optimized for job coaches to use with audio learning clients",
            "summarization_for_braille": "A concise, structured version optimized for tactile reading without losing essential job training details",
            "email_body": "Create an email body for this document for the person who will receive the document translation to speech in braile and wav format",
            "email_subject": "Create an email subject for this document for the person who will receive the document translation to speech in braile and wav format"
        }

        For the speech summarization (for audio learners):
        - Create content specifically designed for job coaches to read aloud or use with text-to-speech technology
        - Remove all special characters, symbols, citations, and complex formatting that would disrupt speech flow
        - Break complex workplace concepts into clear, digestible chunks with natural pauses
        - Spell out industry-specific acronyms and vocational terminology on first use
        - Use consistent verbal signposting (e.g., "First step...", "Moving to the next section about workplace accommodations...")
        - Include pronunciation guidance for technical terms in parentheses when needed
        - Focus on sequential, step-by-step instructions that can be easily followed through audio alone
        - Emphasize auditory descriptions of workplace procedures rather than visual references

        For the braille summarization (for tactile readers):
        - Create a concise version (30% shorter than speech version) optimized for efficient braille reading
        - Organize job training content in a clear hierarchical structure with consistent headings
        - Use precise, economical language while preserving all essential employment concepts and skill training details
        - Include all critical workplace instructions, safety information, and procedural steps
        - Format lists of job tasks or requirements with clear numeric or bullet indicators that translate well to braille
        - Prioritize information based on importance to job skill acquisition and workplace success
        - Provide clear, concise descriptions of workplace layouts or equipment that don't rely on visual context
        - Use straightforward syntax that maintains complete meaning in a space-efficient format
        """
        
        # Use the API key from environment variables
        api_key = os.environ["OPENAI_API_KEY"]
        
        # CRITICAL: For Azure OpenAI, the api_version is from your env file and must match deployment
        api_version = "2025-01-01-preview"  # Match what's in your deployment info
        
        # Base endpoint without the deployment path
        azure_endpoint = "https://united-coach-openai.openai.azure.com"
        
        # Deployment name that exactly matches your deployment
        deployment_name = "gpt-4o-mini"
        
        # Log authentication details (securely)
        logging.info(f"Using API key prefix: {api_key[:5]}...")
        logging.info(f"Endpoint: {azure_endpoint}")
        logging.info(f"API Version: {api_version}")
        logging.info(f"Deployment: {deployment_name}")
        
        # Initialize Azure OpenAI client
        client = AzureOpenAI(
            api_key=api_key,
            api_version=api_version,
            azure_endpoint=azure_endpoint
        )
        
        # Send content for analysis, limiting if necessary
        content_limit = 80000 if len(document_content) > 80000 else len(document_content)
        truncated_content = document_content[:content_limit]
        if content_limit < len(document_content):
            truncated_content += "...[content truncated for processing]"
        
        logging.info(f"Sending request to OpenAI with model: {deployment_name}")
        response = client.chat.completions.create(
            model=deployment_name,  # Must match your deployment name exactly
            messages=[
                {"role": "system", "content": system_prompt},
                {"role": "user", "content": f"Analyze this document content with focus on job training, workplace accommodations, and employment skills:\n\n{truncated_content}"}
            ],
            temperature=0.3,
            max_tokens=4096  # Increased to accommodate larger outputs with braille formatting
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
                        "summary": gpt_analysis,
                        "summarization_for_speech": clean_text_for_speech(gpt_analysis),
                        "summarization_for_braille": clean_text_for_braille(gpt_analysis),
                        "email_body": "Document analysis has been completed. Please find attached the accessible formats for your review.",
                        "email_subject": "Document Analysis Completed"
                    }
                    gpt_analysis = json.dumps(analysis_output)
            
            # Parse the JSON to validate and ensure required fields
            analysis_data = json.loads(gpt_analysis)
            
            # Ensure summarization_for_speech exists
            if "summarization_for_speech" not in analysis_data:
                # Create speech version from summary if missing
                analysis_data["summarization_for_speech"] = clean_text_for_speech(analysis_data.get("summary", "No summary available"))
            
            # Ensure summarization_for_braille exists
            if "summarization_for_braille" not in analysis_data:
                # Create braille version from summary if missing
                analysis_data["summarization_for_braille"] = clean_text_for_braille(analysis_data.get("summary", "No summary available"))
            
            # Ensure email fields exist
            if "email_body" not in analysis_data:
                analysis_data["email_body"] = f"Document analysis for {analysis_data.get('title', 'your document')} has been completed. Please find attached the accessible formats for your review."
            
            if "email_subject" not in analysis_data:
                analysis_data["email_subject"] = f"Accessible Document Analysis: {analysis_data.get('title', 'Document')}"
            
            # Remove sentiment if present (not needed in new format)
            if "sentiment" in analysis_data:
                del analysis_data["sentiment"]
                
            # Reserialize to JSON
            gpt_analysis = json.dumps(analysis_data, indent=2)
            logging.info("Successfully validated JSON response")
            
        except json.JSONDecodeError as json_error:
            logging.error(f"Error formatting OpenAI response as JSON: {str(json_error)}")
            # If not valid JSON, create a simple JSON structure with speech-friendly and braille-friendly text
            analysis_output = {
                "title": "Unknown Document",
                "summary": gpt_analysis,
                "summarization_for_speech": clean_text_for_speech(gpt_analysis),
                "summarization_for_braille": clean_text_for_braille(gpt_analysis),
                "email_body": "Document analysis has been completed. Please find attached the accessible formats for your review.",
                "email_subject": "Document Analysis Completed",
                "raw_analysis": gpt_analysis  # Include the full raw response
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
        
        # Create a simplified error response for job coaches
        error_output = {
            "title": "Processing Error",
            "summary": f"There was an error processing the document: {str(e)}",
            "summarization_for_speech": f"There was an error processing your document. The specific error was: {str(e)}. Please try again or contact technical support for assistance.",
            "summarization_for_braille": f"ERROR: {str(e)}. Contact support.",
            "email_body": "An error occurred while processing your document. The system team has been notified.",
            "email_subject": "Document Processing Error",
            "key_points": ["Document processing failed", "Technical error occurred", "Please try again later"],
            "entities": []
        }
        
        # Upload error JSON to inform job coaches
        try:
            error_json = json.dumps(error_output, indent=2)
            file_name = os.path.basename(blob.name).replace('.txt', '_error.json')
            container_name = "gpt-data"
            create_container_if_not_exists(container_name)
            
            blob_client = blob_service_client.get_blob_client(
                container=container_name,
                blob=file_name
            )
            blob_client.upload_blob(error_json, overwrite=True)
            
            # Optional: Send email notification about the error using Azure Communication Services
            if "COMMUNICATION_SERVICES_CONNECTION_STRING" in os.environ or "COMMUNICATION_SERVICES_ENDPOINT" in os.environ:
                try:
                    send_error_notification(blob.name, str(e))
                except Exception as email_error:
                    logging.error(f"Failed to send error notification: {str(email_error)}")
        except Exception as error_handling_error:
            logging.error(f"Error creating error report: {str(error_handling_error)}")

# Import Azure Communication Services for email notifications
try:
    from azure.communication.email import EmailClient
    from azure.core.credentials import AzureKeyCredential
except ModuleNotFoundError:
    logging.warning("Azure Communication Services modules not found. Email notifications will be disabled.")
    # Define empty classes to prevent errors if Azure Communication Services is not installed
    class EmailClient:
        def __init__(self, *args, **kwargs):
            pass
        def send(self, *args, **kwargs):
            logging.warning("Azure Communication Services not installed. Email not sent.")
            return None
    
    class AzureKeyCredential:
        def __init__(self, *args, **kwargs):
            pass

# Enhanced helper function to clean text for speech with job coach emphasis
def clean_text_for_speech(text):
    """
    Optimizes text for speech output specifically for job coaches working with clients who have audio learning needs.
    Focus on making content suitable for reading aloud or text-to-speech technology.
    """
    # Remove citations like [1], [2], etc.
    text = re.sub(r'\[\d+\]', '', text)
    
    # Remove special characters that might cause issues with speech synthesis
    text = re.sub(r'[^\w\s.,;:?!()-]', '', text)
    
    # Replace multiple spaces with a single space
    text = re.sub(r'\s+', ' ', text)
    
    # Replace long dashes with commas for better speech flow
    text = text.replace('—', ', ')
    text = text.replace('--', ', ')
    
    # Replace newlines with periods for better speech synthesis
    text = text.replace('\n', '. ').replace('. . ', '. ')
    
    # Add verbal signposts for job coaches
    if not text.lower().startswith(('first', 'to begin', 'let\'s start')):
        text = "To begin with. " + text
    
    # Add pauses after potential section breaks
    section_transitions = ['next', 'moving on', 'additionally', 'furthermore', 'another important aspect']
    for transition in section_transitions:
        text = re.sub(r'(' + transition + r')', r'. \1', text, flags=re.IGNORECASE)
    
    # Replace common employment acronyms with spelled-out versions
    acronyms = {
        r'\bADA\b': 'Americans with Disabilities Act (A.D.A.)',
        r'\bIDEA\b': 'Individuals with Disabilities Education Act (I.D.E.A.)',
        r'\bSSI\b': 'Supplemental Security Income (S.S.I.)',
        r'\bSSA\b': 'Social Security Administration (S.S.A.)',
        r'\bSSDI\b': 'Social Security Disability Insurance (S.S.D.I.)',
        r'\bPPE\b': 'Personal Protective Equipment (P.P.E.)',
        r'\bOSHA\b': 'Occupational Safety and Health Administration (O.S.H.A.)',
        r'\bIEP\b': 'Individualized Education Program (I.E.P.)',
        r'\bJAN\b': 'Job Accommodation Network (J.A.N.)',
        r'\bVR\b': 'Vocational Rehabilitation (V.R.)'
    }
    
    for acronym, full_text in acronyms.items():
        text = re.sub(acronym, full_text, text)
        # Only replace the first instance to avoid repetition
        text = re.sub(r'(\([A-Z]\.([A-Z]\.)+(A\.)\))', '', text, count=1)
    
    # Add phrases to improve audio navigation
    if len(text) > 1000:
        text = text[:500] + '. End of first section. Beginning next section. ' + text[500:]
    
    return text.strip()

# New helper function to clean text for braille with job coach emphasis
def clean_text_for_braille(text):
    """
    Optimizes text for braille output specifically for job coaches working with clients who have tactile reading needs.
    Focus on creating concise, structured content that preserves essential job training details.
    """
    # Start by making a copy of the text
    braille_text = text
    
    # Remove citations like [1], [2], etc.
    braille_text = re.sub(r'\[\d+\]', '', braille_text)
    
    # Replace multiple spaces with a single space
    braille_text = re.sub(r'\s+', ' ', braille_text)
    
    # Convert long paragraphs into shorter ones for better braille reading
    if len(braille_text) > 500:
        sentences = re.split(r'(?<=[.!?])\s+', braille_text)
        restructured = []
        paragraph = ""
        
        for sentence in sentences:
            if len(paragraph) + len(sentence) > 150:  # Keep paragraphs around 150 chars
                restructured.append(paragraph.strip())
                paragraph = sentence + " "
            else:
                paragraph += sentence + " "
        
        if paragraph:
            restructured.append(paragraph.strip())
        
        braille_text = "\n\n".join(restructured)
    
    # Add structured headings for job training sections if not present
    common_sections = ["skills required", "job responsibilities", "accommodations", 
                       "training steps", "safety procedures", "equipment", "workplace layout"]
    
    for section in common_sections:
        if section.lower() in braille_text.lower() and not re.search(r'^\s*' + re.escape(section) + r':', braille_text, re.MULTILINE | re.IGNORECASE):
            pattern = r'(?i)(\b' + re.escape(section) + r'\b)'
            braille_text = re.sub(pattern, r'\n\n' + section.upper() + ':', braille_text, count=1)
    
    # Format lists with clear numeric indicators that work well in braille
    list_pattern = r'(?:^|\n)[-•](\s+)(.+?)(?=\n[-•]|\n\n|$)'
    replacement = r'\n1.\1\2'
    list_count = 1
    
    def list_replacer(match):
        nonlocal list_count
        result = f"\n{list_count}.{match.group(1)}{match.group(2)}"
        list_count += 1
        return result
    
    braille_text = re.sub(list_pattern, list_replacer, braille_text, flags=re.MULTILINE)
    
    # Make important information stand out with consistent markers
    important_terms = ["caution", "warning", "safety", "required", "essential", "mandatory"]
    for term in important_terms:
        braille_text = re.sub(r'(?i)(\b' + re.escape(term) + r'\b)', r'IMPORTANT - \1', braille_text)
    
    # Ensure the final text is about 30% shorter than the original for efficient braille reading
    if len(braille_text) > len(text) * 0.7:
        # Further condense by removing some descriptive language
        braille_text = re.sub(r'\b(very|extremely|quite|rather|somewhat)\b\s+', '', braille_text)
        
        # If still too long, focus on key points by keeping sentences with relevant terms
        if len(braille_text) > len(text) * 0.7:
            priority_terms = ["job", "work", "skill", "train", "employ", "accommodat", "support", 
                             "assist", "disability", "safety", "procedure", "step", "instruction"]
            
            sentences = re.split(r'(?<=[.!?])\s+', braille_text)
            priority_sentences = [s for s in sentences if any(term in s.lower() for term in priority_terms)]
            if len(priority_sentences) > 0:
                braille_text = ". ".join(priority_sentences)
    
    return braille_text.strip()

# Add a function to send error notifications to job coaches using Azure Communication Services
def send_error_notification(document_name, error_message):
    """
    Sends an email notification to job coaches when document processing fails
    using Azure Communication Services
    """
    try:
        # Get Azure Communication Services configuration from environment variables
        connection_string = os.environ.get("COMMUNICATION_SERVICES_CONNECTION_STRING")
        endpoint = os.environ.get("COMMUNICATION_SERVICES_ENDPOINT")
        api_key = os.environ.get("COMMUNICATION_SERVICES_KEY")
        
        sender_email = os.environ.get("SENDER_EMAIL", "DoNotReply@your-domain.azurecomm.net")
        recipient_email = os.environ.get("COACH_NOTIFICATION_EMAIL", "jobcoach@example.com")
        
        # Check if required config is available
        if not ((connection_string) or (endpoint and api_key)):
            logging.warning("Azure Communication Services configuration not found. Email notification skipped.")
            return
        
        # Initialize the email client using either connection string or endpoint with key
        if connection_string:
            email_client = EmailClient.from_connection_string(connection_string)
        else:
            email_client = EmailClient(endpoint, AzureKeyCredential(api_key))
        
        # Create the email content
        subject = f"Document Processing Error: {document_name}"
        html_content = f"""
        <h2>Document Processing Error</h2>
        <p>There was an error while processing the document <strong>{document_name}</strong>.</p>
        <p><strong>Error details:</strong> {error_message}</p>
        <p>The system has created an error report in the gpt-data container.</p>
        <p>You may need to re-upload the document or contact technical support if this issue persists.</p>
        <hr>
        <p><em>This is an automated message from the Job Coach Document Processing System.</em></p>
        """
        
        # Format for Azure Communication Services
        # Breaking this into multiple steps for clarity
        message = {
            "content": {
                "subject": subject,
                "html": html_content,
                "plainText": f"Document Processing Error: {document_name}\n\nError details: {error_message}\n\nThe system has created an error report in the gpt-data container."
            },
            "recipients": {
                "to": [
                    {
                        "address": recipient_email,
                        "displayName": "Job Coach"
                    }
                ]
            },
            "senderAddress": sender_email
        }
        
        # Send the email
        poller = email_client.begin_send(message)
        result = poller.result()
        
        logging.info(f"Error notification email sent. Message ID: {result.message_id}")
        
    except Exception as e:
        logging.error(f"Failed to send error notification email: {str(e)}")
        # Don't raise the exception - this is a secondary error

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
        
        # Extract the speech-friendly summary from the analysis
        # Use the dedicated speech field if available, otherwise fallback to regular summary
        speech_text = analysis.get("summarization_for_speech", analysis.get("summary", "No summary available."))
        title = analysis.get("title", "Unknown Document")
        
        # Prepare text for speech synthesis
        speech_text = f"Document Title: {title}. {speech_text}"
        
        # Initialize speech synthesizer
        speech_config = speechsdk.SpeechConfig(subscription=speech_key, region=speech_region)
        speech_config.speech_synthesis_voice_name = "en-US-JennyNeural"  # You can change this to your preferred voice
        
        # Create a temporary file for the audio output with unique name
        temp_file_name = f"speech_{int(time.time())}_{os.getpid()}"
        temp_audio_file = tempfile.mktemp(prefix=temp_file_name, suffix='.wav')
        audio_config = speechsdk.audio.AudioOutputConfig(filename=temp_audio_file)
        
        # Create the speech synthesizer
        speech_synthesizer = speechsdk.SpeechSynthesizer(speech_config=speech_config, audio_config=audio_config)
        
        # Synthesize text to speech
        result = speech_synthesizer.speak_text_async(speech_text).get()
        
        # Check the result
        if result.reason == speechsdk.ResultReason.SynthesizingAudioCompleted:
            logging.info("Speech synthesis completed")
            
            # Upload the audio file to the audio-data container
            file_name = os.path.basename(blob.name).replace('.json', '.wav')
            container_name = "audio-data"
            create_container_if_not_exists(container_name)
            
            # Read the audio file and upload it
            with open(temp_audio_file, "rb") as audio_file:
                audio_data = audio_file.read()  # Read data first before closing file
                
            # Close the file before attempting to upload
            # The file is now closed after exiting the with block
            
            # Add a small delay to ensure file is fully released
            time.sleep(0.5)
            
            # Upload to blob storage
            blob_client = blob_service_client.get_blob_client(
                container=container_name,
                blob=file_name
            )
            blob_client.upload_blob(audio_data, overwrite=True)
            
            logging.info(f"Audio file uploaded as {file_name}")
            
        elif result.reason == speechsdk.ResultReason.Canceled:
            cancellation_details = result.cancellation_details
            logging.error(f"Speech synthesis canceled: {cancellation_details.reason}")
            if cancellation_details.reason == speechsdk.CancellationReason.Error:
                logging.error(f"Error details: {cancellation_details.error_details}")
    
    except Exception as e:
        import traceback
        logging.error(f"Error converting to speech: {str(e)}")
        logging.error(f"Traceback: {traceback.format_exc()}")
    finally:
        # Safely remove the temporary audio file with retries
        if 'temp_audio_file' in locals() and os.path.exists(temp_audio_file):
            try:
                # Try multiple times to delete the file
                max_attempts = 5
                for attempt in range(max_attempts):
                    try:
                        os.remove(temp_audio_file)
                        logging.info(f"Successfully removed temporary file on attempt {attempt+1}")
                        break
                    except PermissionError:
                        if attempt < max_attempts - 1:
                            logging.info(f"File still in use, waiting before retry {attempt+1}/{max_attempts}")
                            time.sleep(1)  # Wait before trying again
                        else:
                            logging.warning(f"Could not remove temporary file {temp_audio_file} after {max_attempts} attempts")
            except Exception as del_error:
                logging.warning(f"Error while removing temporary file: {str(del_error)}")

# Function 4: Create Braille Translation HTML
@app.function_name("CreateBrailleHTML")
@app.blob_trigger(arg_name="blob", 
                 path="processed-data/{name}.txt",
                 connection="AzureWebJobsStorage")
def create_braille_html(blob: func.InputStream):
    logging.info(f"Creating Braille HTML for: {blob.name}")
    
    try:
        # Read the text content
        document_content = blob.read().decode('utf-8')
        logging.info(f"Successfully read document for Braille translation, length: {len(document_content)} characters")
        
        # Dictionary to convert ASCII characters to Braille Unicode
        braille_dict = {
            'a': '⠁', 'b': '⠃', 'c': '⠉', 'd': '⠙', 'e': '⠑', 'f': '⠋', 'g': '⠛', 'h': '⠓', 'i': '⠊', 'j': '⠚',
            'k': '⠅', 'l': '⠇', 'm': '⠍', 'n': '⠝', 'o': '⠕', 'p': '⠏', 'q': '⠟', 'r': '⠗', 's': '⠎', 't': '⠞',
            'u': '⠥', 'v': '⠧', 'w': '⠺', 'x': '⠭', 'y': '⠽', 'z': '⠵',
            '0': '⠼⠚', '1': '⠼⠁', '2': '⠼⠃', '3': '⠼⠉', '4': '⠼⠙', '5': '⠼⠑', '6': '⠼⠋', '7': '⠼⠛', '8': '⠼⠓', '9': '⠼⠊',
            ' ': ' ', ',': '⠂', '.': '⠲', '?': '⠦', '!': '⠖', "'": '⠄', '"': '⠄⠄', '-': '⠤', ':': '⠒', ';': '⠆',
            '(': '⠐⠣', ')': '⠐⠜', '/': '⠌', '#': '⠼', '+': '⠬', '=': '⠐⠶', '*': '⠐⠔', '@': '⠈⠁'
        }
        
        # Convert text to Braille
        braille_text = ""
        for char in document_content.lower():
            braille_text += braille_dict.get(char, char)  # Use original char if not in dictionary
        
        # Limit document length if too large (Braille can take up a lot of space)
        max_length = 5000  # Reasonable limit for Braille display
        if len(document_content) > max_length:
            document_content = document_content[:max_length] + "...[content truncated for display]"
            braille_text = braille_text[:max_length*2] + "..."  # Braille may have expansion factors
        
        # Create HTML with both original text and Braille
        html_content = f"""<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document with Braille Translation</title>
    <style>
        body {{
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            line-height: 1.6;
        }}
        .braille-text {{
            font-size: 24px;
            line-height: 2;
            padding: 20px;
            background-color: #f8f8f8;
            border-radius: 5px;
            margin: 20px 0;
        }}
        .original-text {{
            white-space: pre-wrap;
            padding: 20px;
            background-color: #f0f0f0;
            border-radius: 5px;
            margin: 20px 0;
        }}
        h1 {{
            color: #333;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
        }}
        .container {{
            display: flex;
            flex-direction: column;
            gap: 20px;
        }}
        @media print {{
            .braille-text {{
                page-break-inside: avoid;
            }}
        }}
    </style>
</head>
<body>
    <h1>Document with Braille Translation</h1>
    <div class="container">
        <h2>Original Text</h2>
        <div class="original-text">{document_content}</div>
        
        <h2>Braille Translation</h2>
        <div class="braille-text">{braille_text}</div>
    </div>
</body>
</html>"""
        
        # Upload to braille-html container
        file_name = os.path.basename(blob.name).replace('.txt', '.html')
        container_name = "braille-html"
        create_container_if_not_exists(container_name)
        
        blob_client = blob_service_client.get_blob_client(
            container=container_name,
            blob=file_name
        )
        blob_client.upload_blob(html_content, overwrite=True)
        
        # Also upload to the "braille" container
        container_name = "braille"
        create_container_if_not_exists(container_name)
        
        blob_client = blob_service_client.get_blob_client(
            container=container_name,
            blob=file_name
        )
        blob_client.upload_blob(html_content, overwrite=True)
        
        logging.info(f"Braille HTML created and uploaded to braille-html/{file_name} and braille/{file_name}")
        
    except Exception as e:
        import traceback
        logging.error(f"Error creating Braille HTML: {str(e)}")
        logging.error(f"Traceback: {traceback.format_exc()}")


# Function 5: Send Email with Attachments
@app.function_name("SendEmailWithAttachments")
@app.blob_trigger(arg_name="blob", 
                 path="audio-data/{name}.wav",
                 connection="AzureWebJobsStorage")
def send_email_with_attachments(blob: func.InputStream):
    """
    This function is triggered when a WAV file is created in the audio-data container.
    It will find the corresponding JSON analysis and Braille HTML file, then send an email
    with both attachments using Azure Communication Services.
    """
    logging.info(f"Preparing email with attachments for: {blob.name}")
    
    try:
        # Extract the base name without extension to find related files
        base_name = os.path.basename(blob.name).replace('.wav', '')
        
        # Get the JSON analysis file to extract email subject and body
        json_file_name = f"{base_name}.json"
        json_container_name = "gpt-data"
        
        # Get braille HTML file
        html_file_name = f"{base_name}.html"
        braille_container_name = "braille"
        
        # Read the audio WAV content (already triggered by this file)
        audio_data = blob.read()
        
        # Read the JSON analysis
        try:
            json_blob_client = blob_service_client.get_blob_client(
                container=json_container_name,
                blob=json_file_name
            )
            json_content = json_blob_client.download_blob().readall().decode('utf-8')
            analysis = json.loads(json_content)
            
            # Extract email subject and body
            email_subject = analysis.get("email_subject", f"Accessible Document: {base_name}")
            email_body = analysis.get("email_body", "Your document has been processed. Please find attached the audio and braille versions.")
            document_title = analysis.get("title", "Document")
            
            logging.info(f"Successfully retrieved email content from analysis for: {base_name}")
        except Exception as e:
            logging.error(f"Error reading JSON analysis: {str(e)}")
            email_subject = f"Accessible Document: {base_name}"
            email_body = "Your document has been processed. Please find attached the audio and braille versions."
            document_title = base_name
        
        # Read the Braille HTML file
        try:
            braille_blob_client = blob_service_client.get_blob_client(
                container=braille_container_name,
                blob=html_file_name
            )
            braille_content = braille_blob_client.download_blob().readall().decode('utf-8')
            logging.info(f"Successfully retrieved Braille HTML for: {base_name}")
        except Exception as e:
            logging.error(f"Error reading Braille HTML file: {str(e)}")
            braille_content = "<html><body><p>Error retrieving Braille content.</p></body></html>"
        
        # Initialize Azure Communication Services Email client
        connection_string = os.environ.get("COMMUNICATION_SERVICES_CONNECTION_STRING")
        sender_email = os.environ.get("SENDER_EMAIL", "DoNotReply@8bf9b200-74da-4cd2-a7e3-20c344ee25b9.azurecomm.net")
        recipient_email = os.environ.get("COACH_NOTIFICATION_EMAIL", "cristopherwin8@outlook.com")
        
        # Ensure the connection string is available
        if not connection_string:
            logging.error("Communication Services connection string is missing. Email cannot be sent.")
            return
        
        # Create email client
        email_client = EmailClient.from_connection_string(connection_string)
        
        # Enhance the email body with additional context
        enhanced_email_body = f"""
        <html>
        <head>
            <style>
                body {{ font-family: Arial, sans-serif; line-height: 1.6; color: #333; }}
                .container {{ max-width: 600px; margin: 0 auto; padding: 20px; }}
                .header {{ background-color: #0078d4; color: white; padding: 10px 20px; }}
                .content {{ padding: 20px; }}
                .footer {{ font-size: 12px; color: #666; margin-top: 30px; border-top: 1px solid #eee; padding-top: 10px; }}
            </style>
        </head>
        <body>
            <div class="container">
                <div class="header">
                    <h2>Accessible Document Processing Complete</h2>
                </div>
                <div class="content">
                    <p><strong>Document Title:</strong> {document_title}</p>
                    <p>{email_body}</p>
                    <p>This email contains two attachments:</p>
                    <ol>
                        <li><strong>Audio file (.wav)</strong> - A spoken version of the document content that can be played on any device with audio capabilities.</li>
                        <li><strong>Braille HTML file (.html)</strong> - A document with both original text and Braille translation that can be viewed in a web browser or printed.</li>
                    </ol>
                    <p>If you have any questions or need additional formats, please contact the support team.</p>
                </div>
                <div class="footer">
                    <p>This is an automated message from the Job Coach Document Processing System.</p>
                </div>
            </div>
        </body>
        </html>
        """
        
        # Prepare email attachments
        attachments = [
            {
                "name": f"{document_title}_audio.wav",
                "contentType": "audio/wav",
                "contentInBase64": base64.b64encode(audio_data).decode('utf-8')
            },
            {
                "name": f"{document_title}_braille.html",
                "contentType": "text/html",
                "contentInBase64": base64.b64encode(braille_content.encode('utf-8')).decode('utf-8')
            }
        ]
        
        # Format for Azure Communication Services
        message = {
            "content": {
                "subject": email_subject,
                "html": enhanced_email_body,
                "plainText": f"Accessible Document: {document_title}\n\n{email_body}\n\nThis email contains two attachments:\n1. Audio file (.wav)\n2. Braille HTML file (.html)"
            },
            "recipients": {
                "to": [
                    {
                        "address": recipient_email,
                        "displayName": "Job Coach"
                    }
                ]
            },
            "senderAddress": sender_email,
            "attachments": attachments
        }
        
        # Send the email
        poller = email_client.begin_send(message)
        result = poller.result()
        
        logging.info(f"Email sent successfully. Message ID: {result.message_id}")
        
        # Mark the email as sent by creating a flag file in a new container
        container_name = "email-sent-flags"
        create_container_if_not_exists(container_name)
        
        flag_blob_client = blob_service_client.get_blob_client(
            container=container_name,
            blob=f"{base_name}.flag"
        )
        
        # Create a JSON record of the email sending
        email_record = {
            "document_name": base_name,
            "email_sent_time": time.strftime("%Y-%m-%d %H:%M:%S"),
            "recipient": recipient_email,
            "attachments": ["audio.wav", "braille.html"],
            "message_id": result.message_id
        }
        
        flag_blob_client.upload_blob(json.dumps(email_record), overwrite=True)
        
    except Exception as e:
        import traceback
        logging.error(f"Error sending email with attachments: {str(e)}")
        logging.error(f"Traceback: {traceback.format_exc()}")
        
        # Try to send a failure notification
        try:
            send_error_notification(blob.name, f"Failed to send email with attachments: {str(e)}")
        except Exception as notify_error:
            logging.error(f"Failed to send error notification: {str(notify_error)}")

# Helper function to create container if it doesn't exist (referenced in code but not defined)
def create_container_if_not_exists(container_name):
    """Create a container if it doesn't already exist"""
    try:
        container_client = blob_service_client.get_container_client(container_name)
        # Try to get container properties to check if it exists
        container_client.get_container_properties()
    except Exception:
        # Container doesn't exist, create it
        blob_service_client.create_container(container_name)
        logging.info(f"Created container: {container_name}")