output "traffic_manager_fqdn" {
  description = "The FQDN of the created Profile."
  value       = azurerm_traffic_manager_profile.this.fqdn
}
