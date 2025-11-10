# JWT認証用Lambda関数
data "archive_file" "auth_handler_zip" {
  type        = "zip"
  source_dir  = "${path.module}/../../../function/src/auth-handler"
  output_path = "${path.module}/../../../function/dist/auth-handler.zip"
}

resource "aws_lambda_function" "auth_handler" {
  function_name    = "${var.namespace}_auth_handler"
  memory_size      = 256
  timeout          = 10
  handler          = "index.handler"
  runtime          = "nodejs18.x"
  publish          = false
  role             = aws_iam_role.lambda_role.arn
  filename         = data.archive_file.auth_handler_zip.output_path
  source_code_hash = data.archive_file.auth_handler_zip.output_base64sha256

  environment {
    variables = {
      USER_POOL_ID        = aws_cognito_user_pool.main.id
      USER_POOL_CLIENT_ID = aws_cognito_user_pool_client.main.id
      REGION              = var.region
    }
  }

  tags = {
    Name        = "${var.namespace}_Auth Handler Lambda"
    Environment = "Dev"
    Purpose     = "JWT Token Generation"
  }
}

# Lambda関数を作成するterraform
data "archive_file" "sample_zip" {
  type        = "zip"
  source_dir  = "${path.module}/../../../function/src/sample"
  output_path = "${path.module}/../../../function/dist/sample.zip"
}

resource "aws_lambda_function" "sample" {
  function_name    = "${var.namespace}_sample"
  memory_size      = 128
  timeout          = 3
  handler          = "index.handler"
  runtime          = "nodejs18.x"
  publish          = false
  role             = aws_iam_role.lambda_role.arn
  filename         = data.archive_file.sample_zip.output_path
  source_code_hash = data.archive_file.sample_zip.output_base64sha256

  tags = {
    Name        = "${var.namespace}_Sample Lambda"
    Environment = "Dev"
  }
}
