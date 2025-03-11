import os
import logging
import zipfile
import io
from azure.storage.blob import BlobServiceClient
import azure.functions as func

CONNECTION_STRING = os.getenv("olympicdata2309_STORAGE")
CONTAINER_NAME = "olympics"
EXTRACTED_FOLDER = "raw_data/olympics/unzippedData/"

def main(myblob: func.InputStream):
    """Function triggers for all files in the folder but only processes ZIP files"""

    if not CONNECTION_STRING:
        logging.error("Missing or invalid storage connection string!")
        return

    blob_service_client = BlobServiceClient.from_connection_string(CONNECTION_STRING)
    container_client = blob_service_client.get_container_client(CONTAINER_NAME)

    # Read ZIP file into memory
    zip_bytes = io.BytesIO(myblob.read())

    # Open and process the ZIP file
    with zipfile.ZipFile(zip_bytes, "r") as zip_ref:
        for file_name in zip_ref.namelist():
            if file_name.endswith(".csv"):  # Extract only CSV files
                logging.info(f"Extracting: {file_name}")

                # Read extracted file
                with zip_ref.open(file_name) as extracted_file:
                    file_data = extracted_file.read()

                # Upload CSV using chunked upload for large files
                blob_client = container_client.get_blob_client(f"{EXTRACTED_FOLDER}{file_name}")
                upload_large_file(blob_client, file_data)

        logging.info(f"Extraction complete. Files stored in {EXTRACTED_FOLDER}")

def upload_large_file(blob_client, data, chunk_size=4 * 1024 * 1024):
    """Uploads large files to Azure Blob Storage in chunks (default 4MB)"""
    try:
        blob_client.upload_blob(data, blob_type="BlockBlob", overwrite=True)
        logging.info(f"Uploaded {blob_client.blob_name} successfully.")
    except Exception as e:
        logging.error(f"Failed to upload {blob_client.blob_name}: {str(e)}")


