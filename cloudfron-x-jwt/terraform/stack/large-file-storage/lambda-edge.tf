# Lambda@Edge関数のソースコードをZIP化
data "archive_file" "jwt_auth_edge_zip" {
  type        = "zip"
  source_dir  = "../function/src/jwt-auth-edge"
  output_path = "../function/dist/jwt-auth-edge.zip"
}

# Lambda@Edge for jwt認証
# Lambda@Edgeは必ずpublish=true
# Lambda@Edgeの最大値は30秒 viewer-requestは5秒推奨
# --------------------------------------------------
resource "aws_lambda_function" "jwt_auth_edge" {
  provider      = aws.us_east_1
  filename      = data.archive_file.jwt_auth_edge_zip.output_path
  function_name = "${var.namespace}-cloudfront-jwt-auth"
  role          = aws_iam_role.lambda_edge_role.arn
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  publish       = true
  timeout       = 5
  memory_size   = 128

  source_code_hash = data.archive_file.jwt_auth_edge_zip.output_base64sha256

  tags = {
    Name        = "${var.namespace}_CloudFront JWT Auth"
    Environment = "Dev"
    Type        = "Lambda@Edge"
  }
}

resource "aws_cloudwatch_log_group" "jwt_auth_edge_logs" {
  provider          = aws.us_east_1
  name              = "/aws/lambda/us-east-1.${var.namespace}-cloudfront-jwt-auth"
  retention_in_days = 7

  tags = {
    Name        = "${var.namespace}_Lambda@Edge JWT Auth Logs"
    Environment = "Dev"
  }
}
