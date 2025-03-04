locals {
  app_name        = join("-", [var.name_prefix, "app"])
  asp_name        = join("-", [var.name_prefix, "asp"])
  asp_sku         = "S1"
  rg_name         = format("%s-%s", var.name_prefix, "rg")
  sql_admin_name  = "sqladmin"
  sql_db_name     = format("%s-%s", var.name_prefix, "sql-db")
  sql_db_sku      = "S2"
  sql_server_name = join("-", [var.name_prefix, "sql"])
  sql_fwr_name    = "allow-verification-ip"
}
