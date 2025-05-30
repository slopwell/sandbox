resource "github_repository" "sandbox" {
  name         = "sandbox"
  description  = "This is a sandbox repository for testing purposes."
  visibility   = "public"
  has_issues   = true
  has_wiki     = true
  has_projects = false
  auto_init    = true
  topics       = ["terraform", "github", "sandbox"]
}

# first commit
resource "github_repository_file" "initial_commit" {
  repository        = github_repository.sandbox.name
  file              = "README.md"
  content           = "This is initial commit in repository."
  commit_message    = "Initial commit"

}

resource "github_branch_default" "main" {
  repository = github_repository.sandbox.name
  branch     = "main"
}
