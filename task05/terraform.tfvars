
# List of Resource groups
resource_groups = {
  rg_eus = {
    name = "cmtr-69544203-rg-01"
  },
  rg_wus = {
    name = "cmtr-69544203-rg-02"
  },
  rg_cus = {
    name = "cmtr-69544203-rg-03"
  }
}

# Tags
tags = {
  Creator = "oleksandr_holan@epam.com"
}

# Traffic Manager
traffic_manager = {
  profile_name           = "cmtr-69544203-traf"
  rg_key                 = "rg_cus"
  traffic_routing_method = "Performance"
}

# Map of Webapps
webapps = {
  "webapp_eus" = {
    service_plan_props = {
      name         = "cmtr-69544203-asp-01"
      os_type      = "Windows"
      sku_name     = "S1"
      worker_count = 2
    }
    webapp_name = "cmtr-69544203-app-01"
    rg_key      = "rg_eus"
  }
  "webapp_wus" = {
    service_plan_props = {
      name         = "cmtr-69544203-asp-02"
      os_type      = "Windows"
      sku_name     = "S1"
      worker_count = 1
    }
    webapp_name = "cmtr-69544203-app-02"
    rg_key      = "rg_wus"
  }
}

# Map of App Service IP restrictions
webapp_ip_restrictions = {
  "allow-ip" = {
    action      = "Allow"
    ip_address  = "204.153.55.4/32" # Allowed Verification agent IP
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
