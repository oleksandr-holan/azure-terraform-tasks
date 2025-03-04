output "hostname" {
  description = "App Service Plan FQDN"
  value       = azurerm_linux_web_app.app.default_hostname
}
