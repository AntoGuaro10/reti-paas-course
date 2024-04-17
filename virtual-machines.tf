resource "azurerm_network_interface" "paasvm1-nic" {
  name                = "paasvm1153"
  location            = var.location
  resource_group_name = var.resource_group
  ip_configuration {
    name                          = "private"
    subnet_id                     = data.azurerm_virtual_network.paasvnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "PAASVM1-ip"
  }
}

resource "azurerm_linux_virtual_machine" "paasvm1" {
  name                = "PAASVM1"
  resource_group_name = var.resource_group
  location            = var.location
  size                = "Standard B1ms"
  admin_username      = "paas"
  
  network_interface_ids = [ azurerm_network_interface.paasvm1-nic.id ]

  admin_password = var.vm-password
  disable_password_authentication = false

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_HDD_LRS"
  }
}