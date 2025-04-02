# Cardif POC

## Azure Credentials Setup

To deploy this application, you need to set up Azure credentials in your GitHub repository secrets. Follow these steps:

1. Install the Azure CLI and login:
```bash
az login
```

2. Create a service principal and get the credentials:
```bash
az ad sp create-for-rbac --name "cardif-poc-sp" --role contributor \
                         --scopes /subscriptions/<subscription-id> \
                         --sdk-auth
```

This command will output JSON similar to:
```json
{
  "clientId": "<client-id>",
  "clientSecret": "<client-secret>",
  "subscriptionId": "<subscription-id>",
  "tenantId": "<tenant-id>",
  ...
}
```

3. In your GitHub repository:
   - Go to Settings > Secrets and variables > Actions
   - Click "New repository secret"
   - Name: AZURE_CREDENTIALS
   - Value: Paste the entire JSON output from the previous step

## Azure Container Registry Credentials

After Terraform creates the Azure Container Registry, you'll need to set up these additional secrets:

1. Get the ACR credentials:
```bash
az acr credential show --name cardifpocacr --resource-group cardif-poc-RG
```

2. Add these secrets to your GitHub repository:
   - ACR_USERNAME: The username from the ACR credentials (usually the registry name)
   - ACR_PASSWORD: One of the passwords from the ACR credentials

These credentials will allow the GitHub Actions workflow to push images to your Azure Container Registry.