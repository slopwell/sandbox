data "template_file" "openapi" {
  template = file("./open-api.yml")

  vars = {
    # ymlへの引数的なあれ
    apigw_integration_arn = "arn:aws:apigateway:${data.aws_region.default.name}:lambda:path/2015-03-31/functions"
    lambda_sample         = aws_lambda_function.sample.arn
    lambda_detect_text    = aws_lambda_function.detect_text.arn
  }
}

resource "aws_api_gateway_rest_api" "slopwell" {
  name = "slopwell"
  body = data.template_file.openapi.rendered

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "dev" {
  rest_api_id = aws_api_gateway_rest_api.slopwell.id

  triggers = {
    redeployment = sha1(jsonencode([aws_api_gateway_rest_api.slopwell.body]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "dev" {
  stage_name    = "dev"
  rest_api_id   = aws_api_gateway_rest_api.slopwell.id
  deployment_id = aws_api_gateway_deployment.dev.id
}

resource "aws_api_gateway_method_settings" "dev" {
  rest_api_id = aws_api_gateway_rest_api.slopwell.id
  stage_name  = aws_api_gateway_stage.dev.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = false
  }
}

data "aws_iam_policy_document" "api_gateway_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions   = ["execute-api:Invoke"]
    resources = ["${aws_api_gateway_rest_api.slopwell.execution_arn}/*"]
  }
}

resource "aws_api_gateway_rest_api_policy" "policy" {
  rest_api_id = aws_api_gateway_rest_api.slopwell.id
  policy      = data.aws_iam_policy_document.api_gateway_policy.json
}
