data "azurerm_virtual_network" "paasvnet" {
  name                = "PAASVNET"
  resource_group_name = var.resource_group
}

data "azurerm_subnet" "default" {
  name                 = "default"
  virtual_network_name = data.azurerm_virtual_network.paasvnet.name
  resource_group_name  = var.resource_group
}

data "azurerm_network_interface" "paasvm1-nic" {
  name                = "paasvm1153"
  resource_group_name = var.resource_group
}

data "azurerm_public_ip" "paasvm1-ip" {
  name                = "PAASVM1-ip"
  resource_group_name = var.resource_group
}

output "subnet_id" {
  value = data.azurerm_subnet.default.id
}

output "subnets" {
  value = data.azurerm_virtual_network.paasvnet.subnets
}