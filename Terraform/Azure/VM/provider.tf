terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.20.0"
    }
  }
}

provider "azurerm" {
subscription_id = "4fd0a535-ff6b-4048-891f-ee64fe1d8d48"
client_id = "f45de461-bb0e-45e7-99df-9fc1e1a26b5c"
client_secret = var.client_secret
tenant_id = "9340c603-c9e2-4c94-ae41-68a4a658067a"
features {
  
}
}
