variable "subscription_id" {}
variable "tenant_id" {}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

module "network" {
  source              = "../../modules/network"
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = var.vnet_name
  vnet_address_space  = var.vnet_address_space
  subnet_name         = var.subnet_name
  subnet_prefix       = var.subnet_prefix
}

module "nsg" {
  source              = "../../modules/nsg"
  resource_group_name = var.resource_group_name
  location            = var.location
  nsg_name            = var.nsg_name
  subnet_prefix       = var.subnet_prefix
}

module "vm" {
  source               = "../../modules/vm"
  resource_group_name  = var.resource_group_name
  location             = var.location
  subnet_id            = module.network.subnet_id
  vm_specs             = var.vm_specs
  ssh_key_name         = var.ssh_key_name
  ssh_key_resource_group = var.resource_group_name
  ssh_username         = var.ssh_username
}
