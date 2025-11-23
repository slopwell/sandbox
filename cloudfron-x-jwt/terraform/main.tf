module "backend_api" {
  source = "./stack/backend-api"

  namespace = "slopwell"
  region    = "ap-northeast-1"
}

module "large_file_storage" {
  source = "./stack/large-file-storage"

  namespace = "slopwell"
  region    = "ap-northeast-1"

  # Cognito情報をbackend_apiモジュールから取得
  cognito_user_pool_id = module.backend_api.cognito_user_pool_id
  cognito_client_id    = module.backend_api.cognito_user_pool_client_id

  providers = {
    aws.us_east_1 = aws.us_east_1
  }
}
