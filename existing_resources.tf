resource "azurerm_storage_account" "devchaitanya019" {
  name                     = "devchaitanya019"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_ssh_public_key" "Azure_driftking" {
  name                = "Azure_driftking"
  resource_group_name = var.resource_group_name
  location            = var.location
  public_key          = var.ssh_public_key
}
