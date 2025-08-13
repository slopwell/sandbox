# assume role
# 
data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# CloudWatch Logsのポリシー
# 
data "aws_iam_policy_document" "cloudwatch_logs" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
    ]
    resources = [
      "arn:aws:logs:${data.aws_region.default.name}:${data.aws_caller_identity.self.id}:log-group:*",
    ]
  }

  statement {
    actions = [
      "logs:PutLogEvents",
    ]
    resources = [
      "arn:aws:logs:${data.aws_region.default.name}:${data.aws_caller_identity.self.id}:log-group:*:log-stream:*",
    ]
  }
}

# ロールの作成
# 
resource "aws_iam_role" "lambda" {
  path = "/${var.namespace}/"
  name = "${var.namespace}_${basename(dirname(abspath(".")))}_LambdaRole"

  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  inline_policy {
    name   = "CloudWatchLogs"
    policy = data.aws_iam_policy_document.cloudwatch_logs.json
  }
}
