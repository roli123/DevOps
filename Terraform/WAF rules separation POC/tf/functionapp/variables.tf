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
  default = "ApimCachingReference"
}

variable "location" {
  description = "location for all the resources"
  default     = "Australia Central"
}
