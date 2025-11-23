locals {
  namespace  = get_env("NAMESPACE")
}

remote_state {
  backend = "s3"
  config = {
    bucket = "${local.namespace}-tfstate"
    key    = "${local.namespace}/${path_relative_to_include()}/terraform.tfstate"
    region = get_env("AWS_REGION")
    encrypt = true
  }
  generate = {
    path      = "tg_backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

generate "terraform" {
  path      = "tg_terraform.tf"
  if_exists = "overwrite_terragrunt"
  contents = file("./common/terraform.tf")
}

generate "terraform-version" {
  path = ".terraform-version"
  if_exists = "overwrite"
  contents = file("./common/.terraform-version")
  disable_signature = true
}

generate "provider" {
  path      = "tg_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = file("./common/provider.tf")
}

generate "variables" {
  path      = "tg_variables.tf"
  if_exists = "overwrite_terragrunt"
  contents = file("./common/variables.tf")
}

inputs = {
  namespace = local.namespace
}