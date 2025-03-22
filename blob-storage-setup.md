# Blob Storage and CORS Setup for United Coach

This guide provides step-by-step instructions for setting up the required Azure Blob Storage containers and configuring CORS for the United Coach document accessibility solution.

## Setting Up Blob Storage Containers

### Option 1: Using Azure Portal

1. **Create a Storage Account (if you don't have one already)**
   - Navigate to the Azure Portal and search for "Storage accounts"
   - Click "+ Create" to create a new storage account
   - Fill in the required fields:
     - Subscription: Select your subscription
     - Resource group: Use existing or create new (e.g., "united-coach-rg")
     - Storage account name: Enter a unique name (e.g., "unitedcoachstorage")
     - Region: Select a region close to your users
     - Performance: Standard
     - Redundancy: Locally-redundant storage (LRS)
   - Click "Review + create" and then "Create"

2. **Create Required Containers**
   - Navigate to your newly created storage account
   - Select "Containers" from the left menu
   - Click "+ Container" and create the following containers one by one:
     - `pdfs` (for document uploads)
     - `processed-data` (for extracted text)
     - `gpt-data` (for AI analysis results)
     - `audio-data` (for audio versions)
     - `braille` (for braille-formatted HTML)
     - `email-sent-flags` (for email delivery tracking)
   - For each container, set the "Public access level" to "Private (no anonymous access)"

3. **Configure CORS Settings**
   - In your storage account, select "Resource sharing (CORS)" from the left menu
   - Under the "Blob service" tab, add a new CORS rule with the following settings:
     - Allowed origins: `*` (or your specific frontend domain for production)
     - Allowed methods: Select all (DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT)
     - Allowed headers: `*`
     - Exposed headers: `*`
     - Max age: `3600`
   - Click "Save"

4. **Generate SAS Token for Frontend Access**
   - In your storage account, navigate to "Shared access signature"
   - Configure the following permissions:
     - Allowed services: Blob
     - Allowed resource types: Container, Object
     - Allowed permissions: Read, Add, Create, Write
     - Start and expiry time: Set appropriate validity period
     - Allowed protocols: HTTPS only
   - Click "Generate SAS and connection string"
   - Copy the "SAS token" (starts with "?sv=") for use in your frontend .env file

### Option 2: Using Azure CLI

You can also use the Azure CLI script provided in the project repository to automate this process:

```bash
# See the Blob Storage Container Setup Script for the complete code
```

## Updating Environment Variables

After setting up your storage containers and CORS, update the following environment variables in your `.env` file:

```
REACT_APP_STORAGE_URL=https://[your-storage-account-name].blob.core.windows.net/
REACT_APP_CONTAINER_NAME=pdfs
REACT_APP_SAS_TOKEN=[your-sas-token-starting-with-?]
```

## Verifying Your Setup

To verify your setup is correct:

1. **Check Container Access**
   - Run the following command to list blobs in your pdfs container (replace with your values):
   ```
   az storage blob list --container-name pdfs --account-name [your-storage-account] --account-key [your-account-key]
   ```
   - You should see an empty array if the container is new, or a list of existing blobs

2. **Test CORS Configuration**
   - Use a browser developer tool or a tool like Postman to make a preflight OPTIONS request to your storage endpoint
   - The response headers should include your configured CORS settings

3. **Verify SAS Token**
   - Try uploading a sample file to your storage using the SAS token in your application or via a REST client

## Troubleshooting

- **403 Forbidden errors**: Check your SAS token permissions and expiration date
- **CORS errors in browser console**: Verify your CORS configuration is correctly saved and includes your frontend domain
- **Container not found errors**: Ensure container names match exactly what's in your code and are correctly spelled in the storage account

## Notes on Security

For production environments:

- Restrict CORS origins to your specific frontend domain instead of using wildcard (`*`)
- Use short-lived SAS tokens and implement a token refresh mechanism
- Consider using Azure Functions to handle uploads instead of direct-to-blob uploads with SAS tokens
- Enable advanced threat protection on your storage account
