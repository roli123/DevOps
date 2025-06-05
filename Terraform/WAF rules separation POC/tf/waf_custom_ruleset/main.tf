terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.9"
    }
  }
}

provider "azurerm" {
subscription_id = ""
client_id = "f45de461-bb0e-45e7-99df-9fc1e1a26b5c"
client_secret = ""
tenant_id = "9340c603-c9e2-4c94-ae41-68a4a658067a"
features {
  resource_group {
      prevent_deletion_if_contains_resources = false
    }
}
}