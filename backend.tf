terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.0"
    }
  }

  # Remote backend configuration using Azure Storage Account
  backend "azurerm" {
    resource_group_name  = "DevOps_Karma"
    storage_account_name = "devchaitanya019"
    container_name       = "tfstate"
    key                  = "production/terraform.tfstate"
  }
}
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}
