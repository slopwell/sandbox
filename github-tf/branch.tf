resource "github_branch_default" "main" {
  repository = github_repository.sandbox.name
  branch     = "main"
}


resource "github_repository_ruleset" "main_branch_protection" {
  name        = "Main Branch Protection"
  repository  = github_repository.sandbox.name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  rules {
    creation                = true
    update                  = true
    deletion                = true
    required_linear_history = true

    pull_request {
      required_approving_review_count = 1
      require_code_owner_review       = true
      dismiss_stale_reviews_on_push   = true
    }

  }
}
