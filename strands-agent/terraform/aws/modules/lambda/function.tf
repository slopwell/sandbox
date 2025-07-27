resource "aws_lambda_function" "this" {
  function_name    = "${var.namespace}_${var.function_name}"
  handler          = var.handler
  runtime          = var.runtime
  role             = aws_iam_role.lambda_role.arn
  filename         = var.filename
  source_code_hash = filebase64sha256(var.filename)
  environment {
    variables = var.environment_variables
  }
  layers      = [aws_lambda_layer_version.my_layer.arn]
  timeout     = 10
  memory_size = 128
}
