locals {
  # Pinnecone の都合でオハイオリージョン固定
  aws_region = "us-east-1"
}


module "pinecone" {
  source     = "./pinecone"
  aws_region = local.aws_region
}

module "aws" {
  source                  = "./aws"
  namespace               = var.namespace
  pinecone_api_key        = var.pinecone_api_key
  dense_connection_string = module.pinecone.dense_connection_string
  aws_region              = local.aws_region
}

import {
  to = aws_bedrockagent_prompt.prompt
  id = "3UB7RS13CR"
}
