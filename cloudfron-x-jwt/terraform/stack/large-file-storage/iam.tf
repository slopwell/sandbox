# Lambda関数用のIAMロール
data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com", "edgelambda.amazonaws.com"]
    }
  }
}


resource "aws_iam_role" "lambda_edge_role" {
  name = "${var.namespace}-lambda-edge-execution-role"

  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json

  tags = {
    Name        = "${var.namespace}_Lambda@Edge Execution Role"
    Environment = "Dev"
  }
}

# Lambda@Edge用のCloudWatch Logsポリシー
resource "aws_iam_role_policy_attachment" "lambda_edge_logs" {
  role       = aws_iam_role.lambda_edge_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "aws_iam_policy_document" "lambda_edge_additional_policy" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = [
      "arn:aws:logs:*:*:*"
    ]
  }
}

resource "aws_iam_role_policy" "lambda_edge_policy" {
  name   = "${var.namespace}-lambda-edge-additional-policy"
  role   = aws_iam_role.lambda_edge_role.id
  policy = data.aws_iam_policy_document.lambda_edge_additional_policy.json
}
