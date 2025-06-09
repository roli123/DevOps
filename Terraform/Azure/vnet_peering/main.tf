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

resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet01"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name             = "subnet1"
    address_prefixes = ["10.0.1.0/24"]
  }
  depends_on = [ azurerm_resource_group.rg1 ]
}

resource "azurerm_virtual_network" "vnet2" {
  name                = "vnet02"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  address_space       = ["190.168.0.0/16"]

  subnet {
    name             = "subnet2"
    address_prefixes = ["190.168.1.0/24"]
  }
  depends_on = [ azurerm_resource_group.rg1 ]
}

resource "azurerm_virtual_network_peering" "peering1" {
  name                      = "peer1to2"
  resource_group_name       = azurerm_resource_group.rg1.name
  virtual_network_name      = azurerm_virtual_network.vnet1.name
  remote_virtual_network_id = azurerm_virtual_network.vnet2.id
}

resource "azurerm_virtual_network_peering" "peering2" {
  name                      = "peer2to1"
  resource_group_name       = azurerm_resource_group.rg1.name
  virtual_network_name      = azurerm_virtual_network.vnet2.name
  remote_virtual_network_id = azurerm_virtual_network.vnet1.id
}

