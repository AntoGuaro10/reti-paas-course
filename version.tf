terraform {
    required_version = ">= 0.12"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "> 3.59.0, <= 3.77.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "4275b7ef-d10b-4b46-a5ad-e5ff0a1dd9c5"
  tenant_id         = "33ab2861-ffcf-45c4-870c-12dd75f4b254"
  client_id         = "54c0e46b-41fa-40b0-b4fa-1f9078c174a4"
  client_secret     = "PO-8Q~yNVgMD_k31zruKcHpxsBBfpb61b.aAudA0"

}