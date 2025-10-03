output "network_security_group_id" {
  description = "The ID of the Network Security Group."
  value       = module.network.nsg_id
}

output "virtual_machine_public_ips" {
  description = "Public IP addresses for the deployed VMs (if applicable)."
  # The output is a map of VM Name -> Public IP Address
  value = {
    for vm_name, vm_module in module.linux_vms :
    vm_name => vm_module.public_ip_address if vm_module.public_ip_address != null
  }
}

output "virtual_machine_private_ips" {
  description = "Private IP addresses for the deployed VMs."
  value = {
    for vm_name, vm_module in module.linux_vms :
    vm_name => vm_module.private_ip_address
  }
}