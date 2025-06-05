exclusions = [
  {
    match_variable = "RequestHeaderNames"
    operator       = "Equals"
    selector       = "X-Azure-FDID"
  }
]

exclusion_rules = [
  {
    rule_group_name = "REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION"
    rules = [
      {
        rule_id = "943100"
        action  = "Log"
        enabled = false
      }
    ]
    exclusions = []
  },
  {
    rule_group_name = "SQLI"
    rules = [
      {
        rule_id = "942100"
        action  = "Block"
        enabled = true
      },
      {
        rule_id = "942110"
        action  = "AnomalyScoring"
        enabled = false
      }
    ]
    exclusions = [
      {
        match_variable = "RequestCookieNames"
        operator       = "StartsWith"
        selector       = "TestCookie"
      }
    ]
  }
]