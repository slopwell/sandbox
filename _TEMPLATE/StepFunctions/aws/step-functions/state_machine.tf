# aws_sfn_state_machine.sfn_state_machine:
variable "lambda_is_odd_arn" {
  type = string
}

variable "lambda_say_number_arn" {
  type = string
}

data "template_file" "sfn_state_machine" {
  template = file("state_machine.json")

  vars = {
    namespace             = var.namespace
    lambda_is_odd_arn     = var.lambda_is_odd_arn
    lambda_say_number_arn = var.lambda_say_number_arn
  }
}


resource "aws_sfn_state_machine" "sfn_state_machine" {
  name     = "${var.namespace}_sfn_test"
  role_arn = aws_iam_role.stf.arn
  tags     = {}
  type     = "STANDARD"

  definition = data.template_file.sfn_state_machine.rendered

  logging_configuration {
    include_execution_data = false
    level                  = "OFF"
  }

  tracing_configuration {
    enabled = false
  }
}
