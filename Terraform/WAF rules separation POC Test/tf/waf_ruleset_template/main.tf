terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.92.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.28.0"
    }
  }
  
    backend "remote" {
    hostname = "app.terraform.io"
    organization = "avidxchange"
  
    workspaces {
      name = "platformengineering-apim-apim-iac-zz"
    }
  }
}

# AzureRM Provider
provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
}