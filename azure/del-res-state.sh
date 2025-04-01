#!/bin/bash
set -e

echo "--- Azure Resource Deletion Script ---"
echo "This script will delete the entire Resource Group and ALL resources within it."
echo "Make sure you provide the SAME Project Name and Environment as used during creation."
echo ""

echo "Please Input Project Name:"
read project
echo "Please Input ENV (dev/stg/prd):"
read env
echo "Please Input Subscription_ID:"
read sub_id

# --- Define variables (must match the creation script) ---
resource_group_name="$project-$env-iac-rg"

# --- Set Azure context ---
echo "Setting Azure subscription to $sub_id..."
az account set --subscription "$sub_id"

# --- Delete Resource Group ---
echo "Attempting to delete Resource Group '$resource_group_name'..."
echo "WARNING: This will permanently delete the RG and all resources inside it!"
read -p "Are you absolutely sure? (yes/no): " confirmation
if [[ "$confirmation" != "yes" ]]; then
    echo "Deletion cancelled."
    exit 0
fi

echo "Deleting Resource Group '$resource_group_name'. This might take a while..."
# --yes skips the confirmation prompt from az cli itself
# --no-wait makes the command return immediately, but deletion happens in the background. Remove if you want the script to wait.
az group delete --name "$resource_group_name" --yes --no-wait

echo "Deletion initiated for Resource Group '$resource_group_name'. Check the Azure portal for progress."
echo "(If you did not use --no-wait, the script will wait here until deletion completes or fails)."
