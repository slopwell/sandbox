variable "namespace" {
  type = string

}

variable "pinecone_api_key" {
  type = string
}

variable "dense_connection_string" {
  type = string
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}
