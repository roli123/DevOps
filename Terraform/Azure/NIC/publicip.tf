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

locals {
  resource_group_name = "myrg"
  location = "centralindia"
  virtual_network = {
    name = "vnet1"
    address_space = "10.0.0.0/16"
  }
 subnets = [
    {
        name = "subnet1"
        address_prefix = ["10.0.1.0/24"]
    },
    {
        name = "subnet2"
        address_prefix = ["10.0.2.0/24"]
    }
 ]
}

resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = local.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = local.virtual_network.name
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = [local.virtual_network.address_space]
  depends_on = [ azurerm_resource_group.rg ]
}

resource "azurerm_subnet" "s1" {
  name                 = local.subnets[0].name
  resource_group_name  = local.resource_group_name
  virtual_network_name = local.virtual_network.name
  address_prefixes     = local.subnets[0].address_prefix
  depends_on = [ azurerm_virtual_network.vnet ]
}

resource "azurerm_subnet" "s2" {
  name                 = local.subnets[1].name
  resource_group_name  = local.resource_group_name
  virtual_network_name = local.virtual_network.name
  address_prefixes     = local.subnets[1].address_prefix
  depends_on = [ azurerm_virtual_network.vnet ]
}

resource "azurerm_network_interface" "nic" {
  name                = "nic1"
  location            = local.location
  resource_group_name = local.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.s1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.piblicip.id
  }
  depends_on = [ azurerm_subnet.s1 ]
}

resource "azurerm_public_ip" "piblicip" {
  name                = "myPublicIp1"
  resource_group_name = local.resource_group_name
  location            = local.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
  depends_on = [ azurerm_resource_group.rg ]
}