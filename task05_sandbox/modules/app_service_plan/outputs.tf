output "app_service_plan_id" {
  value       = azurerm_service_plan.this.id
  description = "ID of the app service plan."
}
