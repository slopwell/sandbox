output "secret_manager_arn" {
  value = aws_secretsmanager_secret.pinecone_api_key.arn
}
