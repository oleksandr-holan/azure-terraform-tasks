resource "azurerm_service_plan" "asp" {
  name                = var.asp_name
  resource_group_name = var.rg_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.asp_sku
  tags                = var.tags
}

resource "azurerm_linux_web_app" "app" {
  name                = var.app_name
  resource_group_name = var.rg_name
  location            = azurerm_service_plan.asp.location
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {}
  connection_string {
    name  = "SqlDatabaseConnectionString"
    type  = "SQLServer"
    value = var.sql_connection_string
  }
  tags = var.tags
}
