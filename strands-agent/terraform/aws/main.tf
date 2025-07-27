module "secret_manager" {
  source = "./modules/secret-manager"

  namespace        = var.namespace
  pinecone_api_key = var.pinecone_api_key
}

module "bedrock" {
  source = "./modules/bedrock"

  namespace               = var.namespace
  pinecone_api_key        = var.pinecone_api_key
  dense_connection_string = var.dense_connection_string
  secret_manager_arn      = module.secret_manager.secret_manager_arn

  aws_region = var.aws_region
  account_id = data.aws_caller_identity.current.account_id
}

module "lambda" {
  source                = "./modules/lambda"
  namespace             = var.namespace
  function_name         = "my_agent"
  handler               = "agent.handler"
  runtime               = "python3.11"
  filename              = "${path.module}/lambda.zip"
  layer_filename        = "${path.module}/layer.zip"
  environment_variables = { ENV = "prod" }
  iam_policy_json       = data.aws_iam_policy_document.lambda_permissions.json
}

data "aws_iam_policy_document" "lambda_permissions" {
  statement {
    actions   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
    resources = ["arn:aws:logs:*:*:*"]
  }

  # strands-agent用bedrockの権限
  statement {
    actions   = ["bedrock:InvokeModel"]
    resources = ["arn:aws:bedrock:*:${data.aws_caller_identity.current.account_id}:model/*"]
  }
}
