variable "vm_name" {
  description = "The name of the Virtual Machine."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region."
  type        = string
}

variable "vm_size" {
  description = "The Azure VM size."
  type        = string
}

variable "subnet_id" {
  description = "The Subnet ID to attach the NIC to."
  type        = string
}

variable "nsg_id" {
  description = "The Network Security Group ID to associate with the NIC."
  type        = string
}

variable "ssh_username" {
  description = "The administrator username for the VM."
  type        = string
}

variable "ssh_public_key" {
  description = "The content of the SSH public key."
  type        = string
}

variable "vm_image_details" {
  description = "VM image details object."
  type        = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

variable "create_public_ip" {
  description = "Flag to determine if a Public IP should be created."
  type        = bool
  default     = false
}