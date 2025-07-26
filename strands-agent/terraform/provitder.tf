terraform {
  required_providers {
    pinecone = {
      source = "pinecone-io/pinecone"
    }
  }
}

variable "pinecone_api_key" {
  type = string

}

provider "pinecone" {
  api_key = var.pinecone_api_key
}
