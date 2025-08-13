# ------------------------------------------------------------------------------
# CloudFrontからS3へのアクセスを許可する設定
# ------------------------------------------------------------------------------
resource "aws_cloudfront_origin_access_identity" "prod" {
  comment = "access-identity-${namesapace}.s3.amazonaws.com"
}

data "aws_iam_policy_document" "prod" {
  statement {
    actions   = ["s3:GetObject"]
    effect    = "Allow"
    resources = ["${var.s3.prod.arn}/*"]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.prod.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "prod" {
  bucket = var.s3.prod.bucket
  policy = data.aws_iam_policy_document.prod.json
}
