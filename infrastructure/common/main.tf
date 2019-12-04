resource "azurerm_resource_group" "resourcegroup" {
  name     = "terraformStateResourceGroup"
  location = "${var.location}"

  tags = {
    environment = "${var.env}"
    info        = "${var.info_tag}"
    comment     = "Resource group for storing Terraform state"

  }
}

resource "azurerm_storage_account" "storageaccount" {
  name                      = "hkraft"
  resource_group_name       = "${azurerm_resource_group.resourcegroup.name}"
  location                  = "${var.location}"
  account_tier              = "Standard"
  account_replication_type  = "ZRS"
  account_kind              = "StorageV2"
  enable_https_traffic_only = "true"

  tags = {
    env     = "${var.env}"
    info    = "${var.info_tag}"
    comment = "Storage account for storing Terraform state"
  }
}

resource "azurerm_storage_container" "storagecontainer" {
  name                  = "tfstate"
  resource_group_name   = "${azurerm_resource_group.resourcegroup.name}"
  storage_account_name  = "${azurerm_storage_account.storageaccount.name}"
  container_access_type = "private"
}

