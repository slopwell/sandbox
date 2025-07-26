variable "aws_region" {
  type = string
}

# https://registry.terraform.io/providers/pinecone-io/pinecone/latest/docs

resource "pinecone_index" "test" {
  name      = "tftestindex"
  dimension = 10
  spec = {
    serverless = {
      cloud  = "aws"
      region = var.aws_region
    }
  }
}

resource "pinecone_collection" "test" {
  name   = "tftestcollection"
  source = pinecone_index.test.name
}
