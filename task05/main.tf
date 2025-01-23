resource "azurerm_resource_group" "this" {
  name     = var.rg_name
  location = var.location
}

locals {
  key_values = {
    CONTAINER_SAS_TOKEN = data.azurerm_storage_account_blob_container_sas.this.sas
    FILESHARE_SAS_TOKEN = data.azurerm_storage_account_sas.this.sas
  }
  output_file_name = "../infra/verify_params.json"
}

resource "null_resource" "generate_json" {
  triggers = {
    key_values_hash  = sha256(jsonencode(local.key_values))
    output_file_name = local.output_file_name
  }

  provisioner "local-exec" {
    command = <<-EOT
      echo '${jsonencode(local.key_values)}' | jq '.' > ${local.output_file_name}
    EOT
  }
}
