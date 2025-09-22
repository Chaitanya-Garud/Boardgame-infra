data "azurerm_ssh_public_key" "key" {
  name                = var.ssh_key_name
  resource_group_name = var.ssh_key_resource_group
}

resource "azurerm_network_interface" "nic" {
  count               = length(var.vm_specs)
  name                = "${var.vm_specs[count.index].name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  count                = length(var.vm_specs)
  name                 = var.vm_specs[count.index].name
  resource_group_name  = var.resource_group_name
  location             = var.location
  size                 = var.vm_specs[count.index].size
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  admin_username       = var.ssh_username
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.ssh_username
    public_key = data.azurerm_ssh_public_key.key.public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

source_image_reference {
  publisher = "Canonical"
  offer     = "UbuntuServer"
  sku       = "22.04-lts"
  version   = "latest"
  }
}
