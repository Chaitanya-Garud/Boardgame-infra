terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "DevOps_Karma"
    storage_account_name = "devchaitanya019"
    container_name       = "tfstate"
    key                  = "production/terraform.tfstate"
  }
}
