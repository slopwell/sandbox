# API Gateway REST API
# -----------------------------
resource "aws_api_gateway_rest_api" "main" {
  name        = "${local.namespace}-api"
  description = "test"

  tags = {
    Name      = "${local.namespace}-api"
    Namespace = local.namespace
  }
}

# API Gateway Resources and Methods
# -----------------------------
resource "aws_api_gateway_resource" "hello" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "hello"
}

resource "aws_api_gateway_method" "hello_get" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.hello.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "hello_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.main.id
  resource_id             = aws_api_gateway_resource.hello.id
  http_method             = aws_api_gateway_method.hello_get.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.hello.invoke_arn
}

# API Gateway Deployments and Stages
# 視認性悪いからモジュールにしたい
# -----------------------------
resource "aws_api_gateway_deployment" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.hello.id,
      aws_api_gateway_method.hello_get.id,
      aws_api_gateway_integration.hello_lambda.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_api_gateway_method.hello_get,
    aws_api_gateway_integration.hello_lambda,
  ]
}

resource "aws_api_gateway_stage" "prod" {
  deployment_id = aws_api_gateway_deployment.main.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
  stage_name    = "prod"

  tags = {
    Name      = "${local.namespace}-api-prod"
    Namespace = local.namespace
  }
}

resource "aws_api_gateway_stage" "dev" {
  deployment_id = aws_api_gateway_deployment.main.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
  stage_name    = "dev"

  tags = {
    Name      = "${local.namespace}-api-dev"
    Namespace = local.namespace
  }
}

# Lambda Permissions
# source arn ハードコードで良いのか微妙だが、一旦これで。
# -----------------------------
resource "aws_lambda_permission" "apigw_lambda_prod" {
  statement_id  = "AllowExecutionFromAPIGatewayProd"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.hello.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.main.execution_arn}/prod/GET/hello"
}

resource "aws_lambda_permission" "apigw_lambda_dev" {
  statement_id  = "AllowExecutionFromAPIGatewayDev"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.hello.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.main.execution_arn}/dev/GET/hello"
}
