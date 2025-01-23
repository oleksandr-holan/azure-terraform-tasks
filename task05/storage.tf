data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

# Services
resource "azurerm_storage_account" "this" {
  name                            = var.storage_account_name
  resource_group_name             = azurerm_resource_group.this.name
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  https_traffic_only_enabled      = true
  public_network_access_enabled   = true
  allow_nested_items_to_be_public = false
  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [azurerm_subnet.this.id]
    ip_rules                   = [chomp(data.http.myip.response_body), var.agent_ip]
  }
}

resource "azurerm_storage_container" "this" {
  name = var.blob_container_name
  # ignore deprecated warning
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}

resource "azurerm_storage_share" "this" {
  name = var.file_share_name
  # ignore deprecated warning
  storage_account_name = azurerm_storage_account.this.name
  quota                = 50
  access_tier          = "Hot"
}

# Policies
resource "azurerm_storage_management_policy" "this" {
  storage_account_id = azurerm_storage_account.this.id

  rule {
    name    = var.lifecycle_rule_name
    enabled = true
    filters {
      prefix_match = ["data/"]
      blob_types   = ["blockBlob"]
    }
    actions {
      base_blob {
        tier_to_cool_after_days_since_modification_greater_than = 30
      }
    }
  }
}

resource "azurerm_storage_container_immutability_policy" "this" {
  depends_on                            = [azurerm_storage_blob.this]
  storage_container_resource_manager_id = azurerm_storage_container.this.resource_manager_id
  immutability_period_in_days           = 1
  protected_append_writes_all_enabled   = true
}

# Access
data "azurerm_storage_account_blob_container_sas" "this" {
  connection_string = azurerm_storage_account.this.primary_connection_string
  container_name    = azurerm_storage_container.this.name
  https_only        = true

  start  = timeadd(timestamp(), "-48h")
  expiry = timeadd(timestamp(), "168h") # 1 week from now

  permissions {
    read   = true
    add    = false
    create = false
    write  = false
    delete = false
    list   = true
  }
}

data "azurerm_storage_account_sas" "this" {
  connection_string = azurerm_storage_account.this.primary_connection_string
  https_only        = true
  signed_version    = "2017-07-29"

  resource_types {
    service   = true
    container = true
    object    = true
  }

  services {
    blob  = false
    queue = false
    table = false
    file  = true
  }

  start  = timeadd(timestamp(), "-48h")
  expiry = timeadd(timestamp(), "168h") # 1 week from now

  permissions {
    read    = true
    write   = false
    delete  = false
    list    = true
    add     = false
    create  = false
    update  = false
    process = false
    tag     = false
    filter  = false
  }
}

# Data
resource "azurerm_storage_blob" "this" {
  name                   = "test_file.txt"
  storage_account_name   = azurerm_storage_account.this.name
  storage_container_name = azurerm_storage_container.this.name
  type                   = "Block"
  source_content         = "Some contents"
}

resource "local_file" "temp_file" {
  content  = "This is the content of the file"
  filename = "${path.module}/temp_file.txt"
}

resource "azurerm_storage_share_file" "this" {
  name             = "test_file.txt"
  storage_share_id = azurerm_storage_share.this.id
  source           = local_file.temp_file.filename
}
