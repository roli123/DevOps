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
    "ODM_TechImpl": "Azure Front Door"
    "CreatedOnDate": "2024-10-03T08:53:46.1947631Z"
  }
}

import {
  to = azurerm_cdn_frontdoor_firewall_policy.frontdoor_policy
  id = "/subscriptions/fb7f642a-16cf-48a7-8161-58002441290d/resourcegroups/AX-Ae1-Zz-Apim01-RG/providers/Microsoft.Network/frontDoorWebApplicationFirewallPolicies/AxGbZzApimFdWafPolicy"
}

resource "azurerm_cdn_frontdoor_firewall_policy" "frontdoor_policy" {
  name                              = "AxGbZzApimFdWafPolicy"
  resource_group_name               = data.azurerm_resource_group.hub_rg.name
  sku_name                          = azurerm_cdn_frontdoor_profile.cdn_frontdoor_profile.sku_name
  mode                              = "Prevention"
  managed_rule {
    type    = "Microsoft_DefaultRuleSet"
    version = "2.1"
    action  = "Block"

    exclusion {
      match_variable = "RequestHeaderNames"
      selector       = "X-Azure-FDID"
      operator    = "Equals"        
    }

    override {
      rule_group_name = "MS-ThreatIntel-WebShells"

      rule {
        action  = "AnomalyScoring"
        enabled = false
        rule_id = "99005002"
      }
      rule {
        action  = "AnomalyScoring"
        enabled = false
        rule_id = "99005003"
      }
    }
  }
  tags = {
    "CreatedOnDate": "2024-10-03T08:53:46.1948646Z"
    "ODM_Domain": "Cloud Infrastructure Services",
    "ODM_Env": "Np",
    "ODM_TechImpl": "Azure API Management"
  }
}