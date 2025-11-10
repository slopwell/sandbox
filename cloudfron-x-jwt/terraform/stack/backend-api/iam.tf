# Lambda実行用IAMロール
data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = "${var.namespace}-lambda-execution-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json

  tags = {
    Name        = "${var.namespace}_Lambda Execution Role"
    Environment = "Dev"
  }
}

# Lambda基本実行権限
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Lambda追加ポリシー（CloudWatch Logs、Cognito等）
data "aws_iam_policy_document" "lambda_additional_policy" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }

  statement {
    actions = [
      "cognito-idp:AdminGetUser",
      "cognito-idp:AdminInitiateAuth",
      "cognito-idp:AdminRespondToAuthChallenge"
    ]
    resources = [aws_cognito_user_pool.main.arn]
  }
}

resource "aws_iam_role_policy" "lambda_additional_policy" {
  name   = "${var.namespace}-lambda-additional-policy"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.lambda_additional_policy.json
}

# API Gateway実行用IAMロール
data "aws_iam_policy_document" "apigateway_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "apigateway_role" {
  name               = "${var.namespace}-apigateway-execution-role"
  assume_role_policy = data.aws_iam_policy_document.apigateway_assume_role.json

  tags = {
    Name        = "${var.namespace}_API Gateway Execution Role"
    Environment = "Dev"
  }
}

# API GatewayからLambdaを呼び出す権限
data "aws_iam_policy_document" "apigateway_lambda_invoke" {
  statement {
    actions   = ["lambda:InvokeFunction"]
    resources = ["*"]
  }

  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "apigateway_lambda_invoke" {
  name   = "${var.namespace}-apigateway-lambda-invoke"
  role   = aws_iam_role.apigateway_role.id
  policy = data.aws_iam_policy_document.apigateway_lambda_invoke.json
}

data "aws_iam_policy_document" "apigateway_cloudwatch_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "apigateway_cloudwatch_role" {
  name               = "${var.namespace}-apigateway-cloudwatch-role"
  assume_role_policy = data.aws_iam_policy_document.apigateway_cloudwatch_assume_role.json

  tags = {
    Name        = "${var.namespace}_API Gateway CloudWatch Role"
    Environment = "Dev"
  }
}

resource "aws_iam_role_policy_attachment" "apigateway_cloudwatch_logs" {
  role       = aws_iam_role.apigateway_cloudwatch_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
}
