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
  resource_group {
      prevent_deletion_if_contains_resources = false
    }
}
}

data "azurerm_client_config" "current" {}


data "azurerm_resource_group" "apim_rg" {
  name = "ax-ae1-Np-ApimCachingReference-RG"
}