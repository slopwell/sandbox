# Cognito User Pool
resource "aws_cognito_user_pool" "main" {
  name = "${var.namespace}-user-pool"

  # ユーザー名設定
  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]

  # ユーザー属性スキーマ
  schema {
    name                = "email"
    attribute_data_type = "String"
    required            = true
    mutable             = true

    string_attribute_constraints {
      min_length = 5
      max_length = 255
    }
  }

  tags = {
    Environment = "Dev"
  }
}

# Cognito User Pool Client
resource "aws_cognito_user_pool_client" "main" {
  name         = "${var.namespace}-user-pool-client"
  user_pool_id = aws_cognito_user_pool.main.id

  # トークン有効期限（秒）
  token_validity_units {
    id_token      = "minutes"
    access_token  = "minutes"
    refresh_token = "days"
  }

  id_token_validity      = 60 # hours
  access_token_validity  = 60 # hours
  refresh_token_validity = 30 # days


  # 認証フロー
  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH"
  ]

  # クライアントシークレットを生成しない（フロントエンド用）
  generate_secret = false

  # セキュリティ設定
  prevent_user_existence_errors = "ENABLED"

  # 読み取り・書き込み属性
  read_attributes  = ["email"]
  write_attributes = ["email"]
}

# # Cognito User Pool Domain（ホストUIのため）
# resource "aws_cognito_user_pool_domain" "main" {
#   domain       = "${var.namespace}-auth-domain"
#   user_pool_id = aws_cognito_user_pool.main.id
# }
