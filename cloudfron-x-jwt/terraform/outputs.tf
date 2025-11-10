output "cloudfront_domain_name" {
  description = "CloudFront"
  value       = module.large_file_storage.cloudfront_domain_name
}

output "cognito_user_pool_id" {
  description = "Cognito User Pool ID"
  value       = module.backend_api.cognito_user_pool_id
}

output "cognito_user_pool_client_id" {
  description = "Cognito User Pool Client ID"
  value       = module.backend_api.cognito_user_pool_client_id
}

# API Gateway情報
output "api_gateway_url" {
  description = "API Gateway URL"
  value       = module.backend_api.api_gateway_url
}

output "api_endpoints" {
  description = "API endpotints"
  value       = module.backend_api.endpoints
}

