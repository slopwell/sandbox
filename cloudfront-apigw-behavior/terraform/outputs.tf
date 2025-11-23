# -----------------------------
# Outputs
# -----------------------------

output "cloudfront_domain_name" {
  description = "CloudFront distribution domain name"
  value       = aws_cloudfront_distribution.main.domain_name
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = aws_cloudfront_distribution.main.id
}

output "api_gateway_invoke_url_prod" {
  description = "API Gateway invoke URL for prod stage"
  value       = aws_api_gateway_stage.prod.invoke_url
}

output "api_gateway_invoke_url_dev" {
  description = "API Gateway invoke URL for dev stage"
  value       = aws_api_gateway_stage.dev.invoke_url
}

output "lambda_function_name" {
  description = "Lambda function name"
  value       = aws_lambda_function.hello.function_name
}

output "lambda_function_arn" {
  description = "Lambda function ARN"
  value       = aws_lambda_function.hello.arn
}

output "test_url" {
  description = "CloudFront test URL (access via /api/hello)"
  value       = "https://${aws_cloudfront_distribution.main.domain_name}/api/hello"
}
