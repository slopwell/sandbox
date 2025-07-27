resource "aws_iam_role" "lambda_role" {
  name               = "${var.namespace}_${var.function_name}-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "lambda_policy" {
  name   = "${var.namespace}_${var.function_name}-policy"
  role   = aws_iam_role.lambda_role.id
  policy = var.iam_policy_json
}
