resource "aws_iam_role" "eventbridge_schedule_role" {
  name = "slopwell-sandbox_${aws_lambda_function.function.function_name}"
  path = "/slopwell-sandbox/"

  assume_role_policy = data.aws_iam_policy_document.assume_role_scheduler.json

  inline_policy {
    name   = "lambda-invoking"
    policy = data.aws_iam_policy_document.lambda_invoking.json
  }
}

output "lambda_role_arn" {
  value = aws_iam_role.eventbridge_schedule_role.arn
}


output "lambda_role_name" {
  value = aws_iam_role.eventbridge_schedule_role.name
}
