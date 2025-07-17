#!/bin/bash
# Usage: ./scripts/sync-secrets.sh <keyvault-name> <secret-name> <env-var-name>
# Example: ./scripts/sync-secrets.sh kv-myvault my-secret VITE_API_KEY
set -e
KV_NAME=$1
SECRET_NAME=$2
ENV_VAR_NAME=$3
SECRET_VALUE=$(az keyvault secret show --vault-name "$KV_NAME" --name "$SECRET_NAME" --query value -o tsv)
echo "$ENV_VAR_NAME=$SECRET_VALUE" >> .env
