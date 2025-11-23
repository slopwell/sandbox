module "large_file_storage" {
  source = "./stack/large-file-storage"

  namespace = "slopwell"
  region    = "us-east-1"

  providers = {
    aws.us_east_1 = aws.us_east_1
  }
}

module "backend_api" {
  source = "./stack/backend-api"

  namespace = "slopwell"
  region    = "ap-northeast-1"
}
