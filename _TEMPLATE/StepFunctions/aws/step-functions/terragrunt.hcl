include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "lambda_is_odd" {
  config_path  = "${get_parent_terragrunt_dir("root")}/functions/is-odd-number/tfm"
  mock_outputs = {
    qualified_arn = "arn:aws:lambda:us-east-1:123456789012:function:is-odd-number"
  }
}
dependency "lambda_say_number_arn" {
  config_path  = "${get_parent_terragrunt_dir("root")}/functions/say-number/tfm"
  mock_outputs = {
    qualified_arn = "arn:aws:lambda:us-east-1:123456789012:function:say-number"
  }
}

inputs = {
  lambda_is_odd_arn     = dependency.lambda_is_odd.outputs.qualified_arn
  lambda_say_number_arn = dependency.lambda_say_number_arn.outputs.qualified_arn
}