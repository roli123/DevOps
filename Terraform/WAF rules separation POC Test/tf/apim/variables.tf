variable "azure_subscription_id" {
  description = "Id of subscription to deploy resource to"
}

variable "environment" {
  default = "Np"
}

variable "capability_domain" {
  default = "Saas Infrastructure Engineering"
}

variable "capability" {
  default = "FrontDoorWAF"
}

variable "location" {
  description = "location for all the resources"
  default     = "Australia Central"
}

variable "function_app_name" {
  description = "Name of the function app"
  default     = "ax-ae1-Np-ApimCachingReference-api"  
}

variable "api_operations" {
  description = "List of API operations to create"
  type = list(object({
    operation_id  = string
    display_name  = string
    method        = string
    url_template  = string
    tags          = optional(list(string), [])
  }))
  default = [
    {
      operation_id  = "getUsers"
      display_name  = "Get users"
      method        = "GET"
      url_template  = "/users"
      tags          = ["users", "read"]
    },
    {
      operation_id  = "createUser"
      display_name  = "Create user"
      method        = "POST"
      url_template  = "/users"
      tags          = ["users", "create"]
    }
  ]
}


