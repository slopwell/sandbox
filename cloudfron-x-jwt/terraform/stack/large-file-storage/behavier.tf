# /api/* をAPI-GWにフォワード
# stageはdev
resource "aws_cloudfront_behavior" "api_gw" {
  path_pattern           = "/api/*"
  target_origin_id       = "APIGW-${aws_api_gateway_rest_api.main.id}"
  viewer_protocol_policy = "redirect-to-https"
  allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
  cached_methods         = ["GET", "HEAD"]

  cache_policy_id = aws_cloudfront_cache_policy.api_gw_cache_policy.id

  # lambda_function_association {
  #   event_type   = "origin-request"
  #   lambda_arn   = aws_lambda_function.api_gw_auth_edge.qualified_arn
  #   include_body = false
  # }

  origin_request_policy_id = aws_cloudfront_origin_request_policy.api_gw_orp.id

  forwarded_values {
    cookies {
      forward = "none"
    }
    query_string = false
  }

  min_ttl     = 0
  default_ttl = 0
  max_ttl     = 0
}
