
resource "azurerm_log_analytics_workspace" "la" {
  name                = "ax-ae1-${var.environment}-${var.capability}-la"
  location            = azurerm_resource_group.caching_rg.location
  resource_group_name = azurerm_resource_group.caching_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  depends_on = [azurerm_resource_group.caching_rg]

}

resource "azurerm_application_insights" "ai" {
  name                = "ax-ae1-${var.environment}-${var.capability}-ai"
  location            = azurerm_resource_group.caching_rg.location
  resource_group_name = azurerm_resource_group.caching_rg.name
  application_type    = "web"
  retention_in_days   = 30
  workspace_id        = azurerm_log_analytics_workspace.la.id
  
  tags = {
    ODM_Env       = var.environment
    ODM_TechImpl  = "Azure API Management"
    ODM_Domain    = "Cloud Infrastructure Services"
  }
}

output "connection_string" {
  sensitive = true
  value = azurerm_application_insights.ai.connection_string
}