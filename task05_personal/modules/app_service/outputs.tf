output "default_site_hostname" {
  description = "The default hostname of the Windows Web App."
  value       = azurerm_windows_web_app.this.default_hostname
}

output "id" {
  description = "The ID of the Windows Web App."
  value       = azurerm_windows_web_app.this.id
}
