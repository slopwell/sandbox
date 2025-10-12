terraform {
  required_version = "1.5.0"

  backend "local" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.26.0"
    }
  }
}

locals {
  json      = jsondecode(file("${path.module}/instance.json"))
  instances = { for i, instance in local.json.instances : tostring(i) => instance }
  namespace = "slopwell-sandbox"
  az        = "ap-northeast-1d"
}

module "s3" {
  source = "./moudule/s3"
  Name   = local.namespace
}

module "vpc" {
  source = "./moudule/vpc"
  Name   = local.namespace
  az     = local.az
}

module "iam" {
  source        = "./moudule/iam"
  s3_bucket_arn = module.s3.bucket_arn
}

module "ec2" {
  source = "./moudule/ec2"

  for_each    = local.instances
  Name        = each.value.name
  env         = each.value.env
  itype       = each.value.itype
  volume_size = each.value.volume_size

  inbound_cidr          = "0.0.0.0/0"
  instance_profile_name = module.iam.instance_profile_name
  subnet_id             = module.vpc.subnet_id
}
