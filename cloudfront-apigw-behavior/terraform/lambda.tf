# Lambda IAM Role
# -----------------------------
resource "aws_iam_role" "lambda_exec" {
  name = "${local.namespace}-lambda-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name      = "${local.namespace}-lambda-exec-role"
    Namespace = local.namespace
  }
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Lambda Function
# -----------------------------
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda/hello.js"
  output_path = "${path.module}/lambda/hello.zip"
}

resource "aws_lambda_function" "hello" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "${local.namespace}-hello-function"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "hello.handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = "nodejs20.x"
  timeout          = 10

  tags = {
    Name      = "${local.namespace}-hello-function"
    Namespace = local.namespace
  }
}
