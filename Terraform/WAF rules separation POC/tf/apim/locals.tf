# # locals.tf - Complete file with HTTP data source and operations

# # First, declare the HTTP data source
# # data "http" "open_api_specification" {
# #   url = "https://${var.function_app_name}.azurewebsites.net"
  
  
#   # Add retry logic for when app is starting up
#   retry {
#     attempts     = 5
#     min_delay_ms = 3000
#     max_delay_ms = 10000
#   }
  
#   request_headers = {
#     Accept = "application/json"
#     User-Agent = "Terraform"
#   }
# }

# # Then use it in locals
# locals {
#   # Parse the swagger response safely
#   open_api_specification = try(jsondecode(data.http.open_api_specification.response_body), {})
  
#   # Safe operations block
#   operations = flatten([
#     for endpoint_path, endpoint_methods in try(local.open_api_specification.paths, {}) : [
#       for method_name, method_details in endpoint_methods : {
#         operationId = method_details.operationId
#         policy = templatefile("./Policies/${method_details.operationId}.xml", {
#           tags = try(method_details.tags, [])
#         })
#       }
#     ]
#   ])
# }