resource "azurerm_api_management" "apimshared" {
  name                = "AX-Ae1-Zz-Shared02-APIM"
  location            = data.azurerm_resource_group.apim_rg.location  # Update with your RG reference
  resource_group_name = data.azurerm_resource_group.apim_rg.name
  
  publisher_name      = "R&A"
  publisher_email     = "rolisingh820@gmail.com"  # Update with valid email
  
  sku_name = "Developer_1"  # Options: Developer_1, Basic_1, Standard_1, Premium_1
}

resource "azurerm_api_management_api" "ApimCachingApi" {
  name                = "apim-caching-reference-api"
  resource_group_name = data.azurerm_resource_group.apim_rg.name
  api_management_name = azurerm_api_management.apimshared.name
  revision            = "1"
  display_name        = "Apim Caching Reference"
  path                = "apimcachingreference" 
  protocols           = ["https"]
  service_url         = "https://${var.function_app_name}.azurewebsites.net"
}

resource "azurerm_api_management_api_operation" "api_operations" {
  for_each = { for op in var.api_operations : op.operation_id => op }

  operation_id        = each.value.operation_id
  api_name            = azurerm_api_management_api.ApimCachingApi.name
  api_management_name = azurerm_api_management.apimshared.name
  resource_group_name = data.azurerm_resource_group.apim_rg.name

  display_name = each.value.display_name
  method       = each.value.method
  url_template = each.value.url_template

  response {
    status_code = 200
    description = "Successful response"
  }
}

resource "azurerm_api_management_api_operation_policy" "operation_policies" {
  for_each = azurerm_api_management_api_operation.api_operations

  operation_id        = each.value.operation_id
  api_name            = each.value.api_name
  api_management_name = each.value.api_management_name
  resource_group_name = each.value.resource_group_name

  xml_content = file("./Policies/${each.key}.xml")
}