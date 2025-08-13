include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "eventbridge_schedule_role" {
  config_path = "${get_parent_terragrunt_dir("root")}/aws/iam"

  mock_outputs = {
    role_arn  = "arn:aws:iam::${get_aws_account_id()}:role/service-role/Lambda_BasicAuth"
    role_name = "Lambda_BasicAuth"
  }
}

inputs = {
  lambda_role_arn  = dependency.eventbridge_schedule_role.outputs.role_arn
  lambda_role_name = dependency.eventbridge_schedule_role.outputs.role_name
}