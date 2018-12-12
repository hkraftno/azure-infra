terraform {
  backend "azurerm" {
    storage_account_name = "hkraft"
    container_name       = "tfstate"
    key                  = "common.terraform.tfstate"
  }
}

