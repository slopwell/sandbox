# clone用
output "github_repository_url" {
  value = "https://github.com/${var.github_owner}/${github_repository.sandbox.name}.git"
}
