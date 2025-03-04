variable "allowed_ip_address" {
  type        = string
  description = "Allowed IP address"
}

variable "kv_name" {
  description = "Key Vault name"
  type        = string
}

variable "kv_rg_name" {
  description = "Key Vault Resource Group name"
  type        = string
}

variable "location" {
  type        = string
  description = "Location for resources"
}

variable "name_prefix" {
  description = "Common resources name prefix"
  type        = string
}

variable "tags" {
  description = "A mapping of tags that should be assigned to resources"
  type        = map(string)
  default     = {}
}
