terraform {
    backend "azurerm" {
      resource_group_name  = "RGPAASCOURSE"
      storage_account_name = "paasstgaccount1"
      container_name       = "tfstate"
      key                  = "terraform.tfstate"
  }
}
