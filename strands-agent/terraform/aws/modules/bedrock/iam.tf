data "aws_iam_policy_document" "agent_trust" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["bedrock.amazonaws.com"]
      type        = "Service"
    }
    condition {
      test     = "StringEquals"
      values   = [var.account_id]
      variable = "aws:SourceAccount"
    }
    condition {
      test     = "ArnLike"
      values   = ["arn:aws:bedrock:${var.aws_region}:${var.account_id}:agent/*"]
      variable = "AWS:SourceArn"
    }
  }
}

data "aws_iam_policy_document" "agent_permissions" {
  statement {
    actions = ["bedrock:InvokeModel"]
    resources = [
      "arn:aws:bedrock:${var.aws_region}::foundation-model/amazon.nova-lite-v1:0",
    ]
  }

  # Knowledge Base permissions
  statement {
    actions = [
      "bedrock:Retrieve",
      "bedrock:RetrieveAndGenerate"
    ]
    resources = ["*"]
  }

  # S3 permissions for RAG documents
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket"
    ]
    resources = [
      "arn:aws:s3:::${var.namespace}-rag-bucket-v2",
      "arn:aws:s3:::${var.namespace}-rag-bucket-v2/*"
    ]
  }

  # Secrets Manager permissions for Pinecone API key
  statement {
    actions = [
      "secretsmanager:GetSecretValue"
    ]
    resources = [
      var.secret_manager_arn,
      "${var.secret_manager_arn}*"
    ]
  }
}

resource "aws_iam_role" "agent_role" {
  assume_role_policy = data.aws_iam_policy_document.agent_trust.json
  name               = "AmazonBedrockExecutionRoleForAgents_"
}

resource "aws_iam_role_policy" "agent_permissions" {
  policy = data.aws_iam_policy_document.agent_permissions.json
  role   = aws_iam_role.agent_role.id
}

# Knowledge Base specific IAM role
data "aws_iam_policy_document" "knowledge_base_trust" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["bedrock.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "knowledge_base_permissions" {
  # Titan embedding model permissions
  statement {
    actions = ["bedrock:InvokeModel"]
    resources = [
      "arn:aws:bedrock:${var.aws_region}::foundation-model/amazon.titan-embed-text-v2:0",
    ]
  }

  # S3 permissions for RAG documents
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket"
    ]
    resources = [
      "arn:aws:s3:::${var.namespace}-rag-bucket-v2",
      "arn:aws:s3:::${var.namespace}-rag-bucket-v2/*"
    ]
  }

  # Secrets Manager permissions for Pinecone API key
  statement {
    actions = [
      "secretsmanager:GetSecretValue"
    ]
    resources = [
      var.secret_manager_arn,
      "${var.secret_manager_arn}*"
    ]
  }
}

resource "aws_iam_role" "knowledge_base_role" {
  assume_role_policy = data.aws_iam_policy_document.knowledge_base_trust.json
  name               = "BedrockKnowledgeBaseRole_${var.namespace}_aigent"
}

resource "aws_iam_role_policy" "knowledge_base_permissions" {
  policy = data.aws_iam_policy_document.knowledge_base_permissions.json
  role   = aws_iam_role.knowledge_base_role.id
}
