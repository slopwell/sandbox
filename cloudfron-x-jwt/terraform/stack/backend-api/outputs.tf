# Cognito出力
output "cognito_user_pool_id" {
  description = "Cognito User Pool ID"
  value       = aws_cognito_user_pool.main.id
}
output "cognito_user_pool_client_id" {
  description = "Cognito User Pool Client ID"
  value       = aws_cognito_user_pool_client.main.id
}

output "api_gateway_url" {
  description = "API Gateway URL"
  value       = aws_api_gateway_stage.main.invoke_url
}

output "endpoints" {
  description = "API エンドポイント一覧"
  value = {
    login_endpoint  = "${aws_api_gateway_stage.main.invoke_url}/auth/login"
    sample_endpoint = "${aws_api_gateway_stage.main.invoke_url}/api/sample"
  }
}
