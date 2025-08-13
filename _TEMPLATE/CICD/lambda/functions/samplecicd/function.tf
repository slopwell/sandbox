variable "lambda_role_arn" {
  type = string
}


data "archive_file" "example_slopwell_zip" {
  type        = "zip"
  source_dir  = "./dist"
  output_path = "./dist/index.zip"
}

resource "aws_lambda_function" "example_slopwell" {
  function_name    = "slopwell_example_slopwell_cicd"
  memory_size      = 128
  timeout          = 3
  handler          = "index.handler"
  runtime          = "nodejs18.x"
  publish          = false
  role             = var.lambda_role_arn
  filename         = data.archive_file.example_slopwell_zip.output_path
  source_code_hash = data.archive_file.example_slopwell_zip.output_base64sha256
}
