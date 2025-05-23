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

resource "azurerm_resource_group" "rg1" {
  name     = "myrg"
  location = "West Europe"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet1"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name             = "subnet1"
    address_prefixes = ["10.0.1.0/24"]
  }

  subnet {
    name             = "subnet2"
    address_prefixes = ["10.0.2.0/24"]
  }
  depends_on = [ azurerm_resource_group.rg1 ]

  tags = {
    environment = "Test"
  }
}