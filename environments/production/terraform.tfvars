resource_group_name  = "DevOps_Karma"
location             = "South India"
vnet_name            = "VNET_INDIA_SOUTH"
vnet_address_space   = ["10.0.0.0/16"]
subnet_name          = "Subnet_Main"
subnet_prefix        = "10.0.1.0/24"
nsg_name             = "NSG-Official"
ssh_key_name         = "Azure_driftking"
ssh_username         = "azureuser"

vm_specs = [
  { name = "Master",   size = "Standard_F4s_v2" },
  { name = "Jenkins",  size = "Standard_F4s_v2" },
  { name = "Slave1",   size = "Standard_F4s_v2" },
  { name = "Slave2",   size = "Standard_F4s_v2" },
  { name = "Sonarqube", size = "Standard_B2ms" },
  { name = "Nexus",    size = "Standard_B2ms" },
  { name = "Monitoring", size = "Standard_B2ms" }
]
