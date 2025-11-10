terraform {
  required_version = ">= 1.5.2"

  backend "local" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.11.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = ">= 2.0.0"
    }
  }
}

# デフォルトプロバイダー（ap-northeast-1）
provider "aws" {
  region = "ap-northeast-1"
}

# Lambda@Edgeはus-east-1必須
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

data "aws_caller_identity" "default" {}
data "aws_region" "default" {}

locals {
  namespace = "slopwell"
}
