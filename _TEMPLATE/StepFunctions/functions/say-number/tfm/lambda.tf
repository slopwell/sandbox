locals {
  function_name         = "${var.namespace}_${basename(dirname(abspath(".")))}"
  runtime               = "nodejs18.x"
  memory_size_mb        = 512
  timeout_seconds       = 60
  log_retention_in_days = 1
}

data "archive_file" "package" {
  type        = "zip"
  source_dir  = "bundle"
  output_path = "package.zip"
}

resource "aws_lambda_function" "function" {
  function_name = local.function_name
  runtime       = local.runtime
  memory_size   = local.memory_size_mb
  timeout       = local.timeout_seconds
  handler       = "index.handler"
  publish       = false

  role             = aws_iam_role.lambda.arn
  filename         = data.archive_file.package.output_path
  source_code_hash = data.archive_file.package.output_base64sha256
}

resource "aws_cloudwatch_log_group" "logs" {
  name              = "/aws/lambda/${aws_lambda_function.function.function_name}"
  retention_in_days = local.log_retention_in_days
}

output "qualified_arn" {
  value = aws_lambda_function.function.qualified_arn
}
