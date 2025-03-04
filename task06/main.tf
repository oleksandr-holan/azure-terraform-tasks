data "azurerm_resource_group" "rg" {
  name = local.rg_name
}

data "azurerm_key_vault" "kv" {
  name                = var.kv_name
  resource_group_name = var.kv_rg_name
}

module "sql" {
  depends_on = [
    data.azurerm_key_vault.kv,
    data.azurerm_resource_group.rg,
  ]
  source             = "./modules/sql"
  kv_id              = data.azurerm_key_vault.kv.id
  rg_name            = data.azurerm_resource_group.rg.name
  location           = var.location
  sql_admin_name     = local.sql_admin_name
  sql_server_name    = local.sql_server_name
  fwr_name           = local.sql_fwr_name
  sql_db_name        = local.sql_db_name
  sql_db_sku         = local.sql_db_sku
  allowed_ip_address = var.allowed_ip_address
  tags               = var.tags
}

module "webapp" {
  depends_on            = [module.sql]
  source                = "./modules/webapp"
  rg_name               = data.azurerm_resource_group.rg.name
  location              = var.location
  asp_name              = local.asp_name
  asp_sku               = local.asp_sku
  app_name              = local.app_name
  sql_connection_string = module.sql.sql_connection_string
  tags                  = var.tags
}
