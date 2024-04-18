resource "azurerm_linux_virtual_machine" "paasvm1" {
  name                = "PAASVM1"
  resource_group_name = var.resource_group
  location            = var.location
  size                = "Standard_B1ms"
  admin_username      = "paas"
  
  network_interface_ids = [ data.azurerm_network_interface.paasvm1-nic.id ]

  admin_password = var.vm-password
  disable_password_authentication = false

  os_disk {
    caching = "ReadWrite"
    disk_size_gb = 30
    storage_account_type = "Standard_LRS"
    write_accelerator_enabled = false
  }
  source_image_reference {
    offer     = "0001-com-ubuntu-server-focal"
    publisher = "canonical"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  tags = {
    owner = "Guarisco",
    scope = "paas-course"
  }

  additional_capabilities {
    ultra_ssd_enabled = false
  }
}