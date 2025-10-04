terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"         # This uses the latest compatible azurerm v4.x provider, avoiding older versions
    }
  }

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
