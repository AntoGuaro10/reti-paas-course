terraform {
    backend "azurerm" {
      resource_group_name  = var.resource_group
      storage_account_name = var.storageaccount-tfstate
      container_name       = "tfstate"
      key                  = "terraform.tfstate"
  }
}
