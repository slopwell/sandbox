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
    required_linear_history = true

    pull_request {
      require_code_owner_review = true

      # 管理者（オーナー）はバイパス可能
    }
  }

  bypass_actors {
    actor_type = "RepositoryRole"
    actor_id = 5
    bypass_mode = "always"
  }
}
