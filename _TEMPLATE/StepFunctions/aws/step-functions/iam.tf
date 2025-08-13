# assume role
# 
data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["states.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_invoking" {
  statement {
    actions   = ["lambda:InvokeFunction"]
    effect    = "Allow"
    resources = ["arn:aws:lambda:${data.aws_region.default.name}:${data.aws_caller_identity.self.id}:function:slopwell-sandbox_*"]
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

data "aws_iam_policy_document" "x_ray" {
  statement {
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "xray:PutTraceSegments",
      "xray:PutTelemetryRecords",
      "xray:GetSamplingRules",
      "xray:GetSamplingTargets"
    ]
  }
}


# ロールの作成
# 
resource "aws_iam_role" "stf" {
  path = "/${var.namespace}/"
  name = "${var.namespace}_${basename(dirname(abspath(".")))}_step_functions_role"

  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  inline_policy {
    name   = "CloudWatchLogs"
    policy = data.aws_iam_policy_document.cloudwatch_logs.json
  }

  inline_policy {
    name   = "LambdaInvoking"
    policy = data.aws_iam_policy_document.lambda_invoking.json
  }

  inline_policy {
    name   = "XRay"
    policy = data.aws_iam_policy_document.x_ray.json
  }
}
