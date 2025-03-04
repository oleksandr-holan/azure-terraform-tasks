resource "random_password" "sql_password" {
  length           = 16
  special          = true
  override_special = "!$#%"
  min_special      = 1
}

resource "azurerm_key_vault_secret" "sql_admin_name_secret" {
  name         = "sql-admin-name"
  value        = var.sql_admin_name
  key_vault_id = var.kv_id
}

resource "azurerm_key_vault_secret" "sql_admin_password_secret" {
  depends_on   = [random_password.sql_password]
  name         = "sql-admin-password"
  value        = random_password.sql_password.result
  key_vault_id = var.kv_id
}

resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = var.rg_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = azurerm_key_vault_secret.sql_admin_name_secret.value
  administrator_login_password = azurerm_key_vault_secret.sql_admin_password_secret.value

  tags = var.tags
}

resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name             = "AllowAzure"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_mssql_firewall_rule" "allow_verification_ip" {
  name             = var.fwr_name
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = var.allowed_ip_address
  end_ip_address   = var.allowed_ip_address
}

resource "azurerm_mssql_database" "sql_db" {
  name         = var.sql_db_name
  server_id    = azurerm_mssql_server.sql_server.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = var.sql_db_sku

  tags = var.tags
}
