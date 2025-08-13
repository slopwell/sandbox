include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "route53" {
  config_path  = "${get_parent_terragrunt_dir("root")}/aws/route53"
  mock_outputs = {
    zone = {
      id   = "XXXXXXXXXXXXXXXXXXXXx"
      name = "slopwell.com"
      arn  = "arn:aws:route53:::hostedzone/XXXXXXXXXXXXXXXXXXXXx"
    }
  }
}

dependency "s3" {
  config_path  = "${get_parent_terragrunt_dir("root")}/aws/s3"
  mock_outputs = {
    s3 = {
      web_prod = {
        bucket               = "slopwell"
        arn                  = "arn:aws:s3:::slopwell"
        regional_domain_name = "slopwell.s3.ap-northeast-1.amazonaws.com"
      }
      web_test = {
        bucket               = "slopwell-test"
        arn                  = "arn:aws:s3:::slopwell-test"
        regional_domain_name = "slopwell-test.s3-ap-northeast-1.amazonaws.com"
      }
    }
  }
}

inputs = {
  r53_zone = dependency.route53.outputs.zone
  s3 = {
    prod = dependency.s3.outputs.s3.web_prod
    test = dependency.s3.outputs.s3.web_test
  }
}
