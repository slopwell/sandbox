output "s3" {
  value = {
    host_prod = {
      bucket               = aws_s3_bucket.host_prod.bucket
      arn                  = aws_s3_bucket.host_prod.arn
      regional_domain_name = aws_s3_bucket.host_prod.bucket_regional_domain_name
    }
    host_test = {
      bucket               = aws_s3_bucket.host_test.bucket
      arn                  = aws_s3_bucket.host_test.arn
      regional_domain_name = aws_s3_bucket.host_test.bucket_regional_domain_name
    }
  }
}
