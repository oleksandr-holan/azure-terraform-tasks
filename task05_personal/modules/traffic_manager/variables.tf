variable "rg_name" {
  description = "The name of the resource group in which to create the Traffic Manager profile."
  type        = string
}

variable "profile_name" {
  description = "The name of the Traffic Manager profile."
  type        = string
}

variable "tags" {
  description = "A mapping of tags that should be assigned to resources"
  type        = map(string)
  default     = {}
}

variable "traffic_manager_endpoints" {
  description = "The endpoint of the thaffic manager."
  type = map(object({
    name = string
    id   = string
  }))
}

variable "traffic_routing_method" {
  description = " Specifies the algorithm used to route traffic."
  type        = string
}
