variable "azure_subscription_id" {
  description = "The Azure subscription ID to use for the provider"
  type        = string
}

variable "azure_resource_group_name" {
  description = "The name of the Azure resource group"
  type        = string  
}

variable "frontdoor_profile_name" {
  description = "The name of the Azure Front Door profile"
  type        = string
  default     = "ax-Zz-apim-fd"  
}

variable "front_door_sku" {
  description = "The SKU for the Azure Front Door profile"
  type        = string
  default     = "Premium_AzureFrontDoor"    
}