# -----------------
# Virtual Network
# -----------------
resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space
}

# -----------------
# Subnet
# -----------------
resource "azurerm_subnet" "main" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.subnet_prefix]
}

# -----------------
# Network Security Group (NSG) and Rules
# -----------------
resource "azurerm_network_security_group" "main" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Map of NSG rules to create
locals {
  nsg_rules = {
    "Allow-SSH" = {
      priority = 100
      port     = "22"
      protocol = "Tcp"
    },
    "Allow-HTTP" = {
      priority = 110
      port     = "80"
      protocol = "Tcp"
    },
    "Allow-HTTPS" = {
      priority = 120
      port     = "443"
      protocol = "Tcp"
    },
    "Allow-Custom-3000-10000" = {
      priority = 130
      port     = "3000-10000"
      protocol = "Tcp"
    },
    "Allow-Custom-6443" = {
      priority = 140
      port     = "6443"
      protocol = "Tcp"
    },
    "Allow-Custom-30000-32767" = {
      priority = 150
      port     = "30000-32767"
      protocol = "Tcp"
    },
  }
}

# Create NSG Rules
resource "azurerm_network_security_rule" "inbound" {
  for_each                    = local.nsg_rules

  name                        = each.key
  priority                    = each.value.priority
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = each.value.protocol
  source_port_range           = "*"
  destination_port_range      = each.value.port
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.main.name
}

# -----------------
# NSG Association to Subnet
# -----------------
# This is where the NSG is attached to the Subnet
resource "azurerm_subnet_network_security_group_association" "main" {
  subnet_id                 = azurerm_subnet.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}

# -----------------
# Outputs
# -----------------
output "vnet_id" {
  value = azurerm_virtual_network.main.id
}

output "subnet_id" {
  value = azurerm_subnet.main.id
}

output "nsg_id" {
  value = azurerm_network_security_group.main.id
}