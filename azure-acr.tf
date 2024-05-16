resource "azurerm_container_registry" "paas-acr" {
  name                = "paasacr1"
  resource_group_name = var.resource_group
  location            = var.location
  sku                 = "Basic"

  retention_policy = {
    enabled           = true
    days              = 7
  }

  tags = {
    owner             = "Guarisco"
    scope             = "paas-course"
  }

}