variable "github_token" {
  description = "GitHub personal access token with repo and admin:org permissions"
  type        = string
  sensitive   = true
}
variable "github_owner" {
  description = "GitHub owner (username or organization name)"
  type        = string
}
