terraform {
  required_version = "1.5.7"

  backend "local" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.44.0"
    }
  }
}

provider "aws" {}
data "aws_caller_identity" "default" {}
data "aws_region" "default" {}
