# -----------------
# Public IP Address (Conditional)
# -----------------
resource "azurerm_public_ip" "main" {
  count               = var.create_public_ip ? 1 : 0 # Only create if required
  name                = "${var.vm_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# -----------------
# Network Interface
# -----------------
resource "azurerm_network_interface" "main" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    # Attach Public IP if it was created
    public_ip_address_id          = try(azurerm_public_ip.main[0].id, null)
  }
}

# -----------------
# NSG Association to NIC (Fix for AzureRM v3+)
# -----------------
# Explicitly associates the NSG (from network module) with the NIC (from vm module)
resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = var.nsg_id
}

# -----------------
# Virtual Machine
# -----------------
resource "azurerm_linux_virtual_machine" "main" {
  name                            = var.vm_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  size                            = var.vm_size
  admin_username                  = var.ssh_username
  disable_password_authentication = true
  network_interface_ids           = [azurerm_network_interface.main.id]

  # VM Image
  source_image_reference {
    publisher = var.vm_image_details.publisher
    offer     = var.vm_image_details.offer
    sku       = var.vm_image_details.sku
    version   = var.vm_image_details.version
  }

  # OS Disk Requirements
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  # SSH Key Setup (using the common key)
  admin_ssh_key {
    username   = var.ssh_username
    public_key = var.ssh_public_key
  }
}

# -----------------
# Outputs
# -----------------
output "public_ip_address" {
  description = "The public IP address of the VM, or null if not created."
  value       = var.create_public_ip ? azurerm_public_ip.main[0].ip_address : null
}

output "private_ip_address" {
  description = "The private IP address of the VM."
  value       = azurerm_network_interface.main.private_ip_address
}