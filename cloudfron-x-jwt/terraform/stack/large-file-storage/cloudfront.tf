# CloudFront Origin Access Control(S3バケットへのアクセス制御)
resource "aws_cloudfront_origin_access_control" "s3_oac" {
  name                              = "${var.namespace}-s3-large-file-storage-oac"
  description                       = "OAC for S3 large file storage"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# Cache Policy（キャッシュ動作を制御）
resource "aws_cloudfront_cache_policy" "jwt_cache_policy" {
  name        = "${var.namespace}-jwt-cache-policy"
  comment     = "Cache policy for JWT authentication"
  default_ttl = 3600
  max_ttl     = 86400
  min_ttl     = 0

  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }

    headers_config {
      header_behavior = "none"
    }

    query_strings_config {
      query_string_behavior = "none"
    }

    enable_accept_encoding_gzip   = true
    enable_accept_encoding_brotli = true
  }
}

# CloudFront Distribution(大容量ファイル配信用)
resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled             = true
  comment             = "CloudFront distribution for JWT-protected large files"
  default_root_object = ""
  price_class         = "PriceClass_200"

  origin {
    domain_name              = aws_s3_bucket.slopwell_large_file_storage.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.s3_oac.id
    origin_id                = "S3-${aws_s3_bucket.slopwell_large_file_storage.id}"
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${aws_s3_bucket.slopwell_large_file_storage.id}"

    cache_policy_id = aws_cloudfront_cache_policy.jwt_cache_policy.id

    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    # Lambda@Edgeの関連付け(viewer-requestでJWT認証)
    lambda_function_association {
      event_type   = "viewer-request"
      lambda_arn   = aws_lambda_function.jwt_auth_edge.qualified_arn
      include_body = false
    }
  }

  # 設定しなくてもいいかも
  # 関連するリージョンだけ開けておく
  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["JP", "US"]
    }
  }

  # SSL証明書設定
  viewer_certificate {
    cloudfront_default_certificate = true
  }

  # カスタムエラーレスポンス(オプション)
  custom_error_response {
    error_code            = 403
    response_code         = 403
    response_page_path    = "/error.html"
    error_caching_min_ttl = 300
  }

  custom_error_response {
    error_code            = 404
    response_code         = 404
    response_page_path    = "/error.html"
    error_caching_min_ttl = 300
  }

  tags = {
    Name        = "${var.namespace}_Large File Distribution"
    Environment = "Dev"
  }
}
