# Create Traffic Manager Profile
resource "azurerm_traffic_manager_profile" "this" {
  name                   = var.profile_name
  resource_group_name    = var.rg_name
  traffic_routing_method = var.traffic_routing_method
  max_return             = 3
  tags                   = var.tags

  dns_config {
    relative_name = var.profile_name
    ttl           = 120
  }

  monitor_config {
    protocol = "HTTP"
    port     = 80
    path     = "/"
  }
}

# Create Traffic Manager Endpoint
resource "azurerm_traffic_manager_azure_endpoint" "this" {
  for_each           = var.traffic_manager_endpoints
  name               = each.value.name
  weight             = 100
  profile_id         = azurerm_traffic_manager_profile.this.id
  target_resource_id = each.value.id
}
