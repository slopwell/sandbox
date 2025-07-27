variable "aws_region" {
  type = string
}

# https://registry.terraform.io/providers/pinecone-io/pinecone/latest/docs

resource "pinecone_index" "dense" {
  name      = "dense-index"
  dimension = 1024
  spec = {
    serverless = {
      cloud  = "aws"
      region = "us-east-1"
    }
  }
}

# resource "pinecone_index" "sparse" {
#   name   = "sparse-index"
#   metric = "dotproduct"
#   spec = {
#     serverless = {
#       cloud  = "aws"
#       region = "us-east-1"
#     }
#   }
# }

# resource "pinecone_collection" "test" {
#   name   = "tftestcollection"
#   source = pinecone_index.test.name
# }

output "dense_connection_string" {
  value = pinecone_index.dense.host

}
