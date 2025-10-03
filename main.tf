# Create the Resource Group if it doesn't exist
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

# -----------------
# Network Module Call
# -----------------
module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  vnet_name           = "VNET_INDIA_SOUTH"
  vnet_address_space  = ["10.0.0.0/16"]
  subnet_name         = "Subnet_Main"
  subnet_prefix       = "10.0.1.0/24"
  nsg_name            = "NSG-Official"
}

# -----------------
# VM Module Calls
# -----------------
# Iterate over the vm_specs variable to create 7 VMs
module "linux_vms" {
  source = "./modules/vm"
  # Use for_each to create a set of modules
  for_each = var.vm_specs

  vm_name             = each.key
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  vm_size             = each.value.size
  subnet_id           = module.network.subnet_id
  nsg_id              = module.network.nsg_id

  ssh_username   = var.ssh_username
  # Use explicit public key content if provided, otherwise read from the given path.
  ssh_public_key = var.ssh_public_key != "" ? var.ssh_public_key : file(var.ssh_public_key_path)

  vm_image_details = var.vm_image_details
  create_public_ip = each.value.public_ip
}