# S3バケット情報
output "s3_bucket_name" {
  description = "S3バケット名"
  value       = aws_s3_bucket.slopwell_large_file_storage.id
}

output "s3_bucket_arn" {
  description = "S3バケットARN"
  value       = aws_s3_bucket.slopwell_large_file_storage.arn
}

output "s3_bucket_regional_domain_name" {
  description = "S3バケットのリージョナルドメイン名"
  value       = aws_s3_bucket.slopwell_large_file_storage.bucket_regional_domain_name
}

# CloudFront情報
output "cloudfront_distribution_id" {
  description = "CloudFront Distribution ID"
  value       = aws_cloudfront_distribution.s3_distribution.id
}

output "cloudfront_domain_name" {
  description = "CloudFront Distribution Domain Name（このURLでアクセス）"
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "cloudfront_distribution_arn" {
  description = "CloudFront Distribution ARN"
  value       = aws_cloudfront_distribution.s3_distribution.arn
}

# Lambda@Edge情報
output "lambda_edge_function_name" {
  description = "Lambda@Edge関数名"
  value       = aws_lambda_function.jwt_auth_edge.function_name
}

output "lambda_edge_function_arn" {
  description = "Lambda@Edge関数ARN"
  value       = aws_lambda_function.jwt_auth_edge.arn
}

output "lambda_edge_qualified_arn" {
  description = "Lambda@Edge関数のQualified ARN（バージョン付き）"
  value       = aws_lambda_function.jwt_auth_edge.qualified_arn
}

# IAMロール情報
output "lambda_edge_role_arn" {
  description = "Lambda@Edge実行ロールARN"
  value       = aws_iam_role.lambda_edge_role.arn
}
