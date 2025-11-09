terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 5.11.0"
      configuration_aliases = [aws.us_east_1]
    }
    archive = {
      source  = "hashicorp/archive"
      version = ">= 2.0.0"
    }
  }
}
