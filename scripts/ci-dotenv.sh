#!/bin/bash
# Usage: ./scripts/ci-dotenv.sh <keyvault-name>
# This script is for CI/CD: fetches secrets from Key Vault and outputs them as GitHub Actions env vars
set -e
KV_NAME=${1:-kv-omnl-doc-portal}
for key in VITE_API_URL VITE_API_KEY; do
  value=$(az keyvault secret show --vault-name "$KV_NAME" --name "$key" --query value -o tsv 2>/dev/null || echo "")
  if [ -n "$value" ]; then
    echo "$key=$value" >> $GITHUB_ENV
  fi
done
