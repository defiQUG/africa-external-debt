#!/bin/bash
# Usage: ./scripts/fill-dotenv.sh <keyvault-name>
# This script copies .env.example to .env and fills in values from Azure Key Vault and GitHub secrets (if available)
set -e
KV_NAME=${1:-kv-omnl-doc-portal}
cp .env.example .env

# Fill from Key Vault
for key in VITE_API_URL VITE_API_KEY; do
  value=$(az keyvault secret show --vault-name "$KV_NAME" --name "$key" --query value -o tsv 2>/dev/null || echo "")
  if [ -n "$value" ]; then
    sed -i '' "s|^$key=.*|$key=$value|" .env
  fi
done

# Fill from environment (for GitHub Actions secrets or local env)
for key in AZURE_CLIENT_ID AZURE_TENANT_ID AZURE_SUBSCRIPTION_ID AZURE_STATIC_WEB_APPS_API_TOKEN; do
  value=$(printenv $key)
  if [ -n "$value" ]; then
    sed -i '' "s|^$key=.*|$key=$value|" .env
  fi
done

echo ".env file created and filled with available secrets. Please review and complete any missing values."
