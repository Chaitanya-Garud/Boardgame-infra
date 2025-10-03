variable "resource_group_name" {
  description = "The name of the resource group to deploy resources into."
  type        = string
  default     = "DevOps_Karma"
}

variable "location" {
  description = "The Azure region where the resources will be deployed."
  type        = string
  default     = "South India"
}

variable "ssh_username" {
  description = "The username for the SSH access on the VMs."
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  description = "The path to the common SSH public key (Azure_driftking.pub)."
  type        = string
  default     = "C:/Users/chait/Downloads/Azure_driftking.pub"
}

variable "vm_image_details" {
  description = "VM image details for all Linux VMs."
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}

variable "vm_specs" {
  description = "A map of VM names and their required size and public IP status."
  type = map(object({
    size      = string
    notes     = string
    public_ip = bool
  }))
  default = {
    Master = {
      size      = "F4s_v2"
      notes     = "Control node"
      public_ip = true
    },
    Jenkins = {
      size      = "F4s_v2"
      notes     = "CI/CD server"
      public_ip = true
    },
    Slave1 = {
      size      = "Standard_B2s"
      notes     = "Worker node"
      public_ip = true
    },
    Slave2 = {
      # ⚠️ UPDATED VM SIZE HERE!
      size      = "Standard_B2s"
      notes     = "Worker node"
      public_ip = true
    },
    Sonarqube = {
      size      = "Standard_B2s"
      notes     = "Code quality"
      public_ip = true
    },
    Nexus = {
      size      = "Standard_B2s"
      notes     = "Artifact repo"
      public_ip = true
    },
    Monitoring = {
      size      = "Standard_B2s"
      notes     = "Metrics/alerts"
      public_ip = true
    }
  }
}

variable "subscription_id" {
  description = "The Azure subscription ID to use for provider and backend operations."
  type        = string
}

variable "ssh_public_key" {
  description = "The content of the SSH public key. If set, this value is used instead of reading a file path."
  type        = string
  default     = ""
}