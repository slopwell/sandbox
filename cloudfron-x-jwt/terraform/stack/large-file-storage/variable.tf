variable "region" {
  type = string
}

variable "namespace" {
  type = string
}

variable "cognito_user_pool_id" {
  type        = string
  description = "Cognito User Pool ID for JWT validation"
}

variable "cognito_client_id" {
  type        = string
  description = "Cognito User Pool Client ID for JWT validation"
}
