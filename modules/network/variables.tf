variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region."
  type        = string
}

variable "vnet_name" {
  description = "Name of the Virtual Network."
  type        = string
}

variable "vnet_address_space" {
  description = "The address space for the VNet."
  type        = list(string)
}

variable "subnet_name" {
  description = "Name of the Subnet."
  type        = string
}

variable "subnet_prefix" {
  description = "The address prefix for the Subnet."
  type        = string
}

variable "nsg_name" {
  description = "Name of the Network Security Group."
  type        = string
}