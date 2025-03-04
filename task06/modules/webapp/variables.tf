variable "app_name" {
  type        = string
  description = "Name of app service"
}

variable "asp_name" {
  type        = string
  description = "Name of app service plan"
}

variable "asp_sku" {
  type    = string
  default = "SKU for service plan"
}

variable "location" {
  type        = string
  description = "Location for resources"
}
variable "rg_name" {
  type        = string
  description = "Resource Group name"
}

variable "sql_connection_string" {
  type        = string
  description = "SQL server connection string"
  sensitive   = true
}

variable "tags" {
  description = "A mapping of tags that should be assigned to resources"
  type        = map(string)
  default     = {}
}

