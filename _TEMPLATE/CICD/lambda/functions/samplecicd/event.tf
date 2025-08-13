variable "lambda_role_name" {
  type = string
}

resource "aws_scheduler_schedule" "example" {
  name       = aws_lambda_function.example_slopwell.function_name
  group_name = "default"
  state      = "DISABLED"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = "cron"

  target {
    arn      = aws_lambda_function.example_slopwell.arn
    role_arn = var.lambda_role_arn
  }
}
