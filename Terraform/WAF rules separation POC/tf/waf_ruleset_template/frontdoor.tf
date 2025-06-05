data "azurerm_resource_group" "hub_rg" {
  name                = var.azure_resource_group_name
}

import {
  to = azurerm_cdn_frontdoor_profile.cdn_frontdoor_profile
  id = "/subscriptions/fb7f642a-16cf-48a7-8161-58002441290d/resourcegroups/AX-Ae1-Zz-Apim01-RG/providers/Microsoft.Cdn/profiles/ax-Zz-apim-fd"
}

resource "azurerm_cdn_frontdoor_profile" "cdn_frontdoor_profile" {
  name                = var.frontdoor_profile_name
  resource_group_name = data.azurerm_resource_group.hub_rg.name
  sku_name            = var.front_door_sku
  response_timeout_seconds = 240
  tags = {
    "ODM_Domain": "Cloud Infrastructure Services",
    "ODM_Env": "Np",
    "ODM_TechImpl": "Azure API Management"
    "CreatedOnDate": "2024-10-03T08:53:46.1947631Z"
  }
}

import {
  to = azurerm_cdn_frontdoor_firewall_policy.modified
  id = "/subscriptions/fb7f642a-16cf-48a7-8161-58002441290d/resourcegroups/AX-Ae1-Zz-Apim01-RG/providers/Microsoft.Network/frontDoorWebApplicationFirewallPolicies/AxGbZzApimFdWafPolicy"
}

data "azurerm_cdn_frontdoor_firewall_policy" "existing" {
  name                              = "AxGbZzApimFdWafPolicy"
  resource_group_name               = data.azurerm_resource_group.hub_rg.name
}

resource "azurerm_cdn_frontdoor_firewall_policy" "modified" {
  name                              = "AxGbZzApimFdWafPolicy"
  resource_group_name               = data.azurerm_resource_group.hub_rg.name
  sku_name                          = data.azurerm_cdn_frontdoor_firewall_policy.existing.sku_name
  mode                              = data.azurerm_cdn_frontdoor_firewall_policy.existing.mode

    # Copy managed rules
  dynamic "managed_rule" {
    for_each = data.azurerm_cdn_frontdoor_firewall_policy.existing.managed_rule
    content {
      type    = managed_rule.value["type"]
      version = managed_rule.value["version"]

      dynamic "exclusion" {
        for_each = managed_rule.value["exclusion"]
        content {
          match_variable = exclusion.value["match_variable"]
          operator = exclusion.value["operator"]
          selector = exclusion.value["selector"]
          match_values = exclusion.value["match_values"]
        }
      }
    }
  }
}