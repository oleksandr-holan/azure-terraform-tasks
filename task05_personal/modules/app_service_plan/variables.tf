
variable "location" {
  description = "The Azure Region where the Service Plan should exist."
  type        = string
}

variable "name" {
  description = "The name which should be used for this Service Plan."
  type        = string
}

variable "os_type" {
  description = "The O/S type for the App Services to be hosted in this plan."
  type        = string
}

variable "rg_name" {
  description = "The name of the Resource Group where the Service Plan should exist."
  type        = string
}

variable "sku_name" {
  description = "The SKU for the plan."
  type        = string
}

variable "tags" {
  description = "A mapping of tags that should be assigned to resources"
  type        = map(string)
}

variable "worker_count" {
  description = "The number of Workers (instances) to be allocated."
  type        = string
}
