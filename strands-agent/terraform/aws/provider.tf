terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.5.0"
    }
  }
}
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_partition" "current" {}
