variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "vnet_name" { type = string }
variable "vnet_address_space" { type = list(string) }
variable "subnet_name" { type = string }
variable "subnet_prefix" { type = string }
variable "nsg_name" { type = string }
variable "vm_specs" {
  type = list(object({
    name = string
    size = string
  }))
}
variable "ssh_key_name" { type = string }
variable "ssh_username" { type = string }
