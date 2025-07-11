variable "github_token" {
  description = "GitHub personal access token with repo and admin:org permissions"
  type        = string
  sensitive   = true
}
variable "github_owner" {
  description = "GitHub owner (username or organization name)"
  type        = string
}

variable "repository_name" {
  type        = string
}

variable "description" {
  type = string
  default = "description of the repository"
}

variable "visibility" {
  type    = string
  default = "private"
}

variable "topics" {
  type    = list(string)
  default = [ "sandbox"]

}
