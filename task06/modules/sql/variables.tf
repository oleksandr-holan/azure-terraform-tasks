variable "allowed_ip_address" {
  description = "Allowed IP Addresses"
  type        = string
}

variable "fwr_name" {
  description = "FWR name"
  type        = string
}

variable "kv_id" {
  description = "KV id"
  type        = string
}

variable "location" {
  type        = string
  description = "Location for resources"
}
variable "rg_name" {
  type        = string
  description = "Resource Group name"
}

variable "sql_admin_name" {
  description = "SQL admin username"
  type        = string
}

variable "sql_db_name" {
  description = "SQL DB name"
  type        = string
}

variable "sql_db_sku" {
  description = "SKU for database"
  type        = string
}
variable "sql_server_name" {
  description = "SQL server name"
  type        = string
}

variable "tags" {
  description = "A mapping of tags that should be assigned to resources"
  type        = map(string)
  default     = {}
}
