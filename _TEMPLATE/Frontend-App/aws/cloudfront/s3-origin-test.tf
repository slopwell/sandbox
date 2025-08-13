# ------------------------------------------------------------------------------
# CloudFrontからS3へのアクセスを許可する設定
# ------------------------------------------------------------------------------
resource "aws_cloudfront_origin_access_identity" "test" {
  comment = "access-identity-${namesapace}.s3.amazonaws.com"
}

data "aws_iam_policy_document" "test" {
  statement {
    actions   = ["s3:GetObject"]
    effect    = "Allow"
    resources = ["${var.s3.test.arn}/*"]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.test.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "test" {
  bucket = var.s3.test.bucket
  policy = data.aws_iam_policy_document.test.json
}
