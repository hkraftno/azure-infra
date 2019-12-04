terraform {
  backend "azurerm" {
    resource_group_name  = "terraformStateResourceGroup"
    storage_account_name = "hkraft"
    container_name       = "tfstate"
    key                  = "common.terraform.tfstate"
  }
}

