#!/bin/bash
declare rg_name

source "../../../shared_libs/shell_functions.sh" &>/dev/null

input_json="../infra/input.json"
output_json="../infra/output.json"
load_vars_from_json_file "$input_json"
load_vars_from_json_file "$output_json"

if [ "$1" == "up" ]; then
  terraform init
  if ! terraform state list 2>/dev/null | grep -q "azurerm_resource_group.this"; then
    terraform import -var-file="$output_json" azurerm_resource_group.this "/subscriptions/$ARM_SUBSCRIPTION_ID/resourceGroups/$rg_name"
    echo "Imported the resource group into Terraform state"
  else
    echo "Resource group already exists in Terraform state. Skipping import."
  fi
  terraform apply -var-file="$output_json" -auto-approve -target=azurerm_storage_account.this
  terraform apply -var-file="$output_json" -auto-approve
elif [ "$1" == "down" ]; then
  terraform destroy -var-file="$output_json" -auto-approve
else
  echo "Usage: $0 {up|down}"
  exit 1
fi
