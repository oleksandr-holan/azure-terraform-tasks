variable "resource_groups" {
  description = "A map of resource group objects"
  type = map(object({
    name     = string
    location = string
  }))
}

variable "tags" {
  description = "A map of tags that will be assigned to resources"
  type        = map(string)
}

variable "traffic_manager" {
  description = "Configuration object for the Azure Traffic Manager"
  type = object({
    profile_name           = string
    rg_key                 = string
    traffic_routing_method = string
  })
}

variable "webapps" {
  description = "Map of webapp and service plan properties"
  type = map(object({
    service_plan_props = object({
      name         = string
      os_type      = string
      sku_name     = string
      worker_count = number
    })
    webapp_name = string
    rg_key      = string
  }))
}

variable "webapp_ip_restrictions" {
  description = "A map of IP restrictions configurations"
  type = map(object({
    action      = string
    ip_address  = optional(string)
    service_tag = optional(string)
    priority    = number
    description = string
  }))
}
