# Create Resource group
data "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location
  tags     = var.tags
}
