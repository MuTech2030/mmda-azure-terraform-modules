resource "azurerm_network_interface" "azure_network_interface" {
  name                = var.azure_network_interface_name
  location            = var.location
  resource_group_name  = var.resource_group_name

  ip_configuration {
    name                          = var.azure_network_interface_name_ip_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Static"
  }
}

resource "azurerm_linux_virtual_machine" "azure_linux_virtual_machine" {
  name                = var.azure_linux_virtual_machine_name
  resource_group_name  = var.resource_group_name
  location            = var.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.azure_network_interface.id,
  ]
  
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}