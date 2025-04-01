#!/bin/bash
set -e

echo "Please Input Project Name:"
read project
echo "Please Input ENV (dev/stg/prd):"
read env
echo "Please Input Subscription_ID:"
read sub_id
echo "Please Input Location (e.g., eastus, japaneast):"
read location

# --- Define variables ---
state="iacstates"
resource_group_name="$project-$env-iac-rg"
# Attempt to create a valid storage account name (lowercase, numbers, 3-24 chars)
# NOTE: This is a basic attempt; complex project/env names might still exceed limits.
temp_iac_name=$(echo "${project}${env}${state}" | tr -d '-' | tr '[:upper:]' '[:lower:]')
iac_storage_account_name=$(echo "${project}${env}${state}" | tr -d '-' | tr '[:upper:]' '[:lower:]')

# Validate storage account name length (basic check)
if [[ ${#iac_storage_account_name} -lt 3 ]]; then
    echo "Error: Generated storage account name '$iac_storage_account_name' is too short (must be >= 3 chars)."
    exit 1
fi

keyvault_name="$project-$env-iac"
keyvault_key_name="$project-$env-iac-key"


# --- Set Azure context ---
echo "Setting Azure subscription to $sub_id..."
az account set --subscription "$sub_id"

# --- Create Resource Group ---
echo "Creating Resource Group '$resource_group_name' in '$location'..."
az group create --name "$resource_group_name" --location "$location" --output none

# --- Create Storage Account for IaC state ---
echo "Creating IaC Storage Account '$iac_storage_account_name'..."
echo "(Full potential name was: $temp_iac_name)" # Show original if truncated
az storage account create --resource-group "$resource_group_name" \
    --name "$iac_storage_account_name" \
    --sku Standard_LRS \
    --encryption-services blob \
    --output none

# --- Get Storage Account Key ---
echo "Retrieving key for Storage Account '$iac_storage_account_name'..."
ACCOUNT_KEY=$(az storage account keys list --resource-group "$resource_group_name" --account-name "$iac_storage_account_name" --query '[0].value' -o tsv)

if [[ -z "$ACCOUNT_KEY" ]]; then
    echo "Error: Failed to retrieve storage account key."
    exit 1
fi

# --- Create Blob Container for IaC state ---
echo "Creating blob container '$state' in Storage Account '$iac_storage_account_name'..."
az storage container create --name "$state" --account-name "$iac_storage_account_name" --account-key "$ACCOUNT_KEY" --output none

# --- Create Key Vault ---
# https://github.com/getsops/sops?tab=readme-ov-file#24encrypting-using-azure-key-vault
echo "Creating Key Vault '$keyvault_name'..."
az keyvault create --name "$keyvault_name" --resource-group "$resource_group_name" --location "$location" --output none

# --- Create Key Vault Key ---
echo "Creating Key Vault key '$keyvault_key_name' in vault '$keyvault_name'..."
az keyvault key create --name "$keyvault_key_name" --vault-name "$keyvault_name" --protection software --ops encrypt decrypt --output none

# --- Show Key Vault Key ID (useful for SOPS config) ---
echo "Retrieving Key Vault Key ID (KID)..."
key_kid=$(az keyvault key show --name "$keyvault_key_name" --vault-name "$keyvault_name" --query key.kid -o tsv)
echo "Key Vault Key ID (KID): $key_kid"

echo "Resource creation process completed successfully."

https://project-dev-iac.vault.azure.net/keys/project-dev-iac-key/206bb8519bdc416d964cf8cccf690273
