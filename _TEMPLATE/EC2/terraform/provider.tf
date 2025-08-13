provider "aws" {
  profile = "localstack"

  region = "ap-northeast-1"

  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    iam        = "http://localhost:4566"
    ec2        = "http://localhost:4566"
    cloudwatch = "http://localhost:4566"
    dynamodb   = "http://localhost:4566"
    s3         = "http://localhost:4566"
  }
}
