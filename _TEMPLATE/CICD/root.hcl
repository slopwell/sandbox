locals {
  namespace  = "slopwell-sandbox"
}

remote_state {
  backend = "s3"
  config = {
    bucket = "slopwell"
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
  contents = file("./aws/common/terraform.tf")
}

generate "terraform-version" {
  path = ".terraform-version"
  if_exists = "overwrite"
  contents = file("./aws/common/.terraform-version")
  disable_signature = true
}

generate "provider" {
  path      = "tg_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = file("./aws/common/provider.tf")
}

generate "variables" {
  path      = "tg_variables.tf"
  if_exists = "overwrite_terragrunt"
  contents = file("./aws/common/variables.tf")
}

inputs = {
  namespace = local.namespace
}
