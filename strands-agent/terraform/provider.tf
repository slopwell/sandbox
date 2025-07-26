terraform {
  required_providers {
    pinecone = {
      source = "pinecone-io/pinecone"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "6.5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


variable "pinecone_api_key" {
  type = string

}

provider "pinecone" {
  api_key = var.pinecone_api_key
}
