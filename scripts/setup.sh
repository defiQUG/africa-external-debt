#!/bin/bash
# Usage: ./scripts/setup.sh <resource-group> <location> <env-name>
set -e
RG_NAME=${1:-omnl_doc_portal_rg}
LOCATION=${2:-"West Europe"}
ENV_NAME=${3:-omnl_doc_portal}

az group create --name "$RG_NAME" --location "$LOCATION" --tags azd-env-name=$ENV_NAME
