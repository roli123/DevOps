resource "azurerm_resource_group" "caching_rg" {
  name     = "ax-ae1-${var.environment}-${var.capability}-RG"
  location = var.location
}

resource "azurerm_service_plan" "appserviceplan" {
  name                = "ax-ae1-${var.environment}-${var.capability}-asp"
  resource_group_name = azurerm_resource_group.caching_rg.name
  location            = azurerm_resource_group.caching_rg.location
  sku_name            = "F1"
  os_type             = "Windows"

  tags = {
    Domain = var.capability_domain
    ODM_Domain   = "Cloud Infrastructure Services"
    ODM_Env      = "${var.environment}"
    ODM_TechImpl = "Azure API Management"
  }

  lifecycle {
    ignore_changes = [tags
    ]
  }
}

resource "azurerm_windows_web_app" "appservice" {
  name                = "ax-ae1-${var.environment}-${var.capability}-api"
  resource_group_name = azurerm_resource_group.caching_rg.name
  location            = azurerm_resource_group.caching_rg.location
  service_plan_id     = azurerm_service_plan.appserviceplan.id
  

  site_config {
    always_on = false
  }

  connection_string {
    name  = "APPLICATIONINSIGHTS_CONNECTION_STRING"
    type  = "Custom"
    value = azurerm_application_insights.ai.connection_string
    
  }

  app_settings = {
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.ai.connection_string
  }

  
  tags = {
    Domain = var.capability_domain
    ODM_Domain   = "Cloud Infrastructure Services"
    ODM_Env      = "${var.environment}"
    ODM_TechImpl = "Azure API Management"
  }

  lifecycle {
    ignore_changes = [tags, ]
  }
}

