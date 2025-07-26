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

