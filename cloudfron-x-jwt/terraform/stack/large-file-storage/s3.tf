# 大容量ファイル格納用
resource "aws_s3_bucket" "slopwell_large_file_storage" {
  bucket = "${var.namespace}-large-file-storage"

  tags = {
    Name        = "${var.namespace}_Large File Storage"
    Environment = "Dev"
    Purpose     = "CloudFront Origin for JWT protected files"
  }
}

# パブリックアクセスブロック
# --------------------------------------------------
resource "aws_s3_bucket_public_access_block" "slopwell_large_file_storage" {
  bucket = aws_s3_bucket.slopwell_large_file_storage.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# バケットポリシー（CloudFront OAC用）
# --------------------------------------------------
# Note: CloudFrontのARNが必要なため、CloudFront作成後に適用される
data "aws_iam_policy_document" "cloudfront_s3_access" {
  statement {
    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.slopwell_large_file_storage.arn}/*"
    ]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.s3_distribution.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "cloudfront_access" {
  bucket = aws_s3_bucket.slopwell_large_file_storage.id
  policy = data.aws_iam_policy_document.cloudfront_s3_access.json

  depends_on = [aws_cloudfront_distribution.s3_distribution]
}

# バージョニングOFF
# --------------------------------------------------
resource "aws_s3_bucket_versioning" "slopwell_large_file_storage" {
  bucket = aws_s3_bucket.slopwell_large_file_storage.id

  versioning_configuration {
    status = "Disabled"
  }
}

# 暗号化 AES256
# --------------------------------------------------
resource "aws_s3_bucket_server_side_encryption_configuration" "slopwell_large_file_storage" {
  bucket = aws_s3_bucket.slopwell_large_file_storage.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
