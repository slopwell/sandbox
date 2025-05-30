terraform {
  required_version = ">= 1.3.0"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.6.0"
    }
  }
  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "github" {
  token = var.github_token
  owner = var.github_owner
}
