output "id" {
  value       = data.azurerm_resource_group.this.id
  description = "The ID of the Resource Group."
}

output "location" {
  value       = data.azurerm_resource_group.this.location
  description = "The Azure Region where the Resource Group exists."
}
