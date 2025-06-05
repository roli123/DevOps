data "azurerm_resource_group" "hub_rg" {
  name = var.azure_resource_group_name
}

resource "azurerm_cdn_frontdoor_profile" "cdn_frontdoor_profile" {
  name                = var.frontdoor_profile_name
  resource_group_name = data.azurerm_resource_group.hub_rg.name
  sku_name            = var.front_door_sku
  response_timeout_seconds = 240
}

resource "azurerm_cdn_frontdoor_firewall_policy" "frontdoor_policy" {
  name                = "AxGbZzApimFdWafPolicy"
  resource_group_name = var.azure_resource_group_name
  sku_name            = azurerm_cdn_frontdoor_profile.cdn_frontdoor_profile.sku_name
  mode                = "Prevention"

  # Disable problematic managed rule globally
  managed_rule {
    type    = "DefaultRuleSet"
    version = "1.0"
    action = "Block"

    override {
      rule_group_name = "SQLI"
      rule {
        rule_id = "942100"
        action  = "Log"   
        enabled = true  # or disable: enabled = false
      }
    }
  }

  # Custom allow rule for /users - highest priority
  custom_rule {
    name      = "AllowUsersApi"
    priority  = 1
    type = "MatchRule"
    action    = "Allow"

    match_condition {
      match_variable   = "RequestUri"
      operator         = "RegEx"
      match_values     = ["/users"]
      negation_condition = false
      transforms       = ["Lowercase"]
    }
  }

  # Custom block rule for all other requests - next priority
  custom_rule {
    name      = "BlockAllExceptUsersApi"
    priority  = 2
    type = "MatchRule"
    action    = "Block"

    match_condition {
      match_variable   = "RequestUri"
      operator         = "RegEx"
      match_values     = ["/users"]
      negation_condition = true
      transforms       = ["Lowercase"]
    }
  }
}

resource "azurerm_dns_zone" "dns" {
  name                = "kochartech.com"
  resource_group_name = data.azurerm_resource_group.hub_rg.name
}

resource "azurerm_cdn_frontdoor_custom_domain" "custom_domain" {
  name                     = "frontdoorcustomdomain"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.cdn_frontdoor_profile.id
  dns_zone_id              = azurerm_dns_zone.dns.id
  host_name                = "contoso.fabrikam.com"

  tls {
    certificate_type    = "ManagedCertificate"
    minimum_tls_version = "TLS12"
  }
}

resource "azurerm_cdn_frontdoor_security_policy" "Security_policy" {
  name                     = "AxSecurityPolicy"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.cdn_frontdoor_profile.id

  security_policies {
    firewall {
      cdn_frontdoor_firewall_policy_id = azurerm_cdn_frontdoor_firewall_policy.frontdoor_policy.id

      association {
        domain {
          cdn_frontdoor_domain_id = azurerm_cdn_frontdoor_custom_domain.custom_domain.id
        }
        patterns_to_match = ["/*"]
      }
    }
  }
}


