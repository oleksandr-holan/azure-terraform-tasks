
# List of Resource groups
resource_groups = {
  rg_eus = {
    name = "cmaz-69544203-mod5-rg-01"
  },
  rg_wus = {
    name = "cmaz-69544203-mod5-rg-02"
  },
  rg_cus = {
    name = "cmaz-69544203-mod5-rg-03"
  }
}

# Tags
tags = {
  Creator = "oleksandr_holan@epam.com"
}

# Traffic Manager
traffic_manager = {
  profile_name           = "cmaz-69544203-mod5-traf"
  rg_key                 = "rg_cus"
  traffic_routing_method = "Performance"
}

# Map of Webapps
webapps = {
  "webapp_eus" = {
    service_plan_props = {
      name         = "cmaz-69544203-mod5-asp-01"
      os_type      = "Windows"
      sku_name     = "S1"
      worker_count = 2
    }
    webapp_name = "cmaz-69544203-mod5-app-01"
    rg_key      = "rg_eus"
  }
  "webapp_wus" = {
    service_plan_props = {
      name         = "cmaz-69544203-mod5-asp-02"
      os_type      = "Windows"
      sku_name     = "S1"
      worker_count = 1
    }
    webapp_name = "cmaz-69544203-mod5-app-02"
    rg_key      = "rg_wus"
  }
}

# Map of App Service IP restrictions
webapp_ip_restrictions = {
  "allow-ip" = {
    action      = "Allow"
    ip_address  = "195.56.119.209/32" # Allowed Verification agent IP
    priority    = 1100
    description = "Allow agent IP"
  }
  "allow-tm" = {
    action      = "Allow"
    service_tag = "AzureTrafficManager"
    priority    = 1000
    description = "TAG restriction - Allow AzureTrafficManager"
  }
}
