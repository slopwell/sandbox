resource "aws_secretsmanager_secret" "pinecone_api_key" {
  name        = "AmazonBedrock-${var.namespace}-pinecone-api-key"
  description = "Pinecone API Key for Bedrock Knowledge Base"
}

resource "aws_secretsmanager_secret_version" "pinecone_api_key" {
  secret_id = aws_secretsmanager_secret.pinecone_api_key.id
  secret_string = jsonencode({
    apiKey = var.pinecone_api_key
  })
}
