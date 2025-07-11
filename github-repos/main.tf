module "web_framework_n_knocks" {
  source = "./modules/repository"

  github_token    = var.github_token
  github_owner    = var.github_owner
  repository_name = "web-framework-n-knocks"
  description     = "Webフレームワークを学ぶためのリポジトリ"
  visibility      = "public"
  topics          = ["web-framework", "learning"]
}
