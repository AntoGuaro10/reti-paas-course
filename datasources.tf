data "azurerm_virtual_network" "paasvnet" {
  name                = "PAASVNET"
  resource_group_name = var.resource_group
}