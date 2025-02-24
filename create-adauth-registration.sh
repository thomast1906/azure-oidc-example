# Create Azure AD application registration
az ad app create --display-name "GitHub-To-Azure-Example" \
  --query appId -o tsv

# Store the app ID in a variable
APP_ID=$(az ad app list --display-name "GitHub-To-Azure-Example" --query [].appId -o tsv)

# Create service principal
az ad sp create --id $APP_ID

# Add OIDC federation credentials
az ad app federated-credential create \
  --id $APP_ID \
  --parameters '{
    "name": "github-oidc-branch",
    "issuer": "https://token.actions.githubusercontent.com",
    "subject": "repo:thomast1906/azure-oidc-example:ref:refs/heads/main",
    "description": "GitHub Actions OIDC - Branch Workflows (main)",
    "audiences": ["api://AzureADTokenExchange"]
  }'