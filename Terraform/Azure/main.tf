terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.20.0"
    }
  }
}

provider "azurerm" {
subscription_id = ""
client_id = ""
client_secret = ""
tenant_id = ""
features {
  
}
}

resource "azurerm_resource_group" "rg" {
  name     = "myrg"
  location = "West Europe"
}

resource "azurerm_storage_account" "storage" {
  name                     = "mariostorage213"
  resource_group_name      = "myrg"
  location                 = "West Europe"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  depends_on = [ azurerm_resource_group.rg ]
}

resource "azurerm_storage_container" "container" {
  name                  = "container1"
  storage_account_id    = azurerm_storage_account.storage.id
  container_access_type = "container"
  depends_on = [ azurerm_storage_account.storage ]
} 

resource "azurerm_storage_blob" "blob" {
  name                   = "new_file"
  storage_account_name   = "mariostorage213"
  storage_container_name = "container1"
  type                   = "Block"
  source                 = "main.tf"
  depends_on = [ azurerm_storage_container.container ]
}
