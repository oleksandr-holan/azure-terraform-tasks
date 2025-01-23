# Create Resource group
module "resource_group" {
  source = "./modules/resource_group"

  for_each = var.resource_groups
  name     = each.value.name
  location = each.value.location
  tags     = var.tags
}

# Create App Service plan
module "app_service_plan" {
  source = "./modules/app_service_plan"

  for_each     = var.webapps
  name         = each.value.service_plan_props.name
  rg_name      = var.resource_groups[each.value.rg_key].name
  location     = module.resource_group[each.value.rg_key].location
  os_type      = each.value.service_plan_props.os_type
  sku_name     = each.value.service_plan_props.sku_name
  worker_count = each.value.service_plan_props.worker_count
  tags         = var.tags
}

# Create App Service
module "app_service" {
  source = "./modules/app_service"

  for_each        = var.webapps
  name            = each.value.webapp_name
  rg_name         = var.resource_groups[each.value.rg_key].name
  location        = module.resource_group[each.value.rg_key].location
  service_plan_id = module.app_service_plan[each.key].app_service_plan_id
  ip_restrictions = var.webapp_ip_restrictions
  tags            = var.tags
}

# Create Traffic Manager
module "traffic_manager" {
  source                 = "./modules/traffic_manager"
  profile_name           = var.traffic_manager.profile_name
  rg_name                = var.resource_groups[var.traffic_manager.rg_key].name
  traffic_routing_method = var.traffic_manager.traffic_routing_method
  traffic_manager_endpoints = {
    for key, value in module.app_service :
    key => {
      name = var.webapps[key].webapp_name
      id   = value.id
    }
  }
  tags       = var.tags
  depends_on = [module.resource_group]
}
