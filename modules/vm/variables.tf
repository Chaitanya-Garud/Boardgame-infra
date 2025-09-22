variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "subnet_id" { type = string }
variable "vm_specs" {
  type = list(object({
    name = string
    size = string
  }))
}
variable "ssh_key_name" { type = string }
variable "ssh_key_resource_group" { type = string }
variable "ssh_username" { type = string }
