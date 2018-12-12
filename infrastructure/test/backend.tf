terraform {
  backend "azurerm" {
    storage_account_name = "hkraft"
    container_name       = "tfstate"
    key                  = "test.terraform.tfstate"
  }
}

