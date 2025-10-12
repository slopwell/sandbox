resource "github_branch_default" "main" {
  repository = github_repository.repository.name
  branch     = "main"

  depends_on = [github_repository_file.initial_commit]
}


resource "github_repository_ruleset" "main_branch_protection" {
  name        = "Main Branch Protection"
  repository  = github_repository.repository.name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  rules {
    required_linear_history = true

    pull_request {
      require_code_owner_review = true
    }
  }

  bypass_actors {
    actor_type = "RepositoryRole"
    actor_id = 5
    bypass_mode = "always"
  }

  depends_on = [github_branch_default.main]
}
