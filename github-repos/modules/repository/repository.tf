resource "github_repository" "repository" {
  name         = var.repository_name
  description  = var.description
  visibility   = var.visibility
  has_issues   = true
  has_wiki     = true
  has_projects = false
  auto_init    = false

  topics       = var.topics
}

# first commit
resource "github_repository_file" "initial_commit" {
  repository     = github_repository.repository.name
  file           = "README.md"
  content        = "This is initial commit in repository."
  commit_message = "Initial commit"
  overwrite_on_create = true
}
