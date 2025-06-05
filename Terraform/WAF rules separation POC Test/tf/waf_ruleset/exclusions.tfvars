azure_subscription_id      = "fb7f642a-16cf-48a7-8161-58002441290d"
azure_resource_group_name  = "AX-Ae1-Zz-Apim01-RG"
frontdoor_profile_name     = "ax-Zz-apim-fd"
frontdoor_sku              = "Premium_AzureFrontDoor"
capability                 = "APIM"
capability_domain          = "PlatformEngineering"
primary_location           = "East US"
apim_instance_name         = "AX-Ae1-Zz-Shared01-APIM"

# Exclusions for Microsoft_DefaultRuleSet
exclusions = [
  {
    match_variable = "RequestHeaderNames"
    operator       = "Equals"
    selector       = "X-Azure-FDID"
  },
  {
    match_variable = "RequestCookieNames"
    operator       = "StartsWith"
    selector       = "TestCookie"
  }
]

#MS-ThreatIntel-AppSec
app_sec_exclusions = [{
    match_variable = "RequestCookieNames"
    operator       = "StartsWith"
    selector       = "TestCookie"
  }]

exclusion_rules = [{
  rules = [ {
    action  = "AnomalyScoring"
    enabled = false
    rule_id = "920300"
  }, {
    action  = "AnomalyScoring"
    enabled = false
    rule_id = "920320"
  } ]
  exclusions = [{
    match_variable = "RequestHeaderNames"
    operator = "Equals"
    selector = "X-Azure-FDID"
  }]
  rule_group_name = "PROTOCOL-ENFORCEMENT"
},{
  rules = [ {
    action  = "AnomalyScoring"
    enabled = true
    rule_id = "99030002"
  } ]
  exclusions = [ {
    match_variable = "RequestCookieNames"
    operator = "StartsWith"
    selector = "TestCookie"
  } ]
  rule_group_name = "MS-ThreatIntel-AppSec"
}]
