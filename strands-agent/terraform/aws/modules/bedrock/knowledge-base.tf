resource "aws_bedrockagent_knowledge_base" "bedrock_knowledge_base_v2" {
  description = null
  name        = "${var.namespace}-knowledge-base-v2"
  region      = var.aws_region
  role_arn    = aws_iam_role.knowledge_base_role.arn
  tags        = null
  knowledge_base_configuration {
    type = "VECTOR"
    vector_knowledge_base_configuration {
      embedding_model_arn = "arn:aws:bedrock:${var.aws_region}::foundation-model/amazon.titan-embed-text-v2:0"
      embedding_model_configuration {
        bedrock_embedding_model_configuration {
          dimensions          = 1024
          embedding_data_type = "FLOAT32"
        }
      }
    }
  }
  storage_configuration {
    type = "PINECONE"
    pinecone_configuration {
      connection_string      = "https://${var.dense_connection_string}"
      credentials_secret_arn = var.secret_manager_arn
      namespace              = null
      field_mapping {
        metadata_field = "metadata"
        text_field     = "text"
      }
    }
  }
}


resource "aws_s3_bucket" "name" {
  bucket = "${var.namespace}-rag-bucket-v2"
}

resource "aws_bedrockagent_data_source" "rag_data_source" {
  name              = "${var.namespace}-rag-data-source-v2"
  knowledge_base_id = aws_bedrockagent_knowledge_base.bedrock_knowledge_base_v2.id

  data_source_configuration {
    type = "S3"
    s3_configuration {
      bucket_arn = aws_s3_bucket.name.arn
    }
  }

  depends_on = [aws_bedrockagent_knowledge_base.bedrock_knowledge_base_v2, aws_s3_bucket.name]
}
