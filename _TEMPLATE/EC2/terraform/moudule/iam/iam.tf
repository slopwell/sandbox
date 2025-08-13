data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "allow_s3_access" {
  statement {
    actions   = ["s3:GetObject", "s3:PutObject", "s3:ListBuckket"]
    resources = [var.s3_bucket_arn]
  }
}

resource "aws_iam_role" "allow_s3_access" {
  name = "allow_s3_access"
  path = "/"
  tags = {}

  assume_role_policy  = data.aws_iam_policy_document.assume_role.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
  inline_policy {
    name   = "ssm_runcommand"
    policy = data.aws_iam_policy_document.allow_s3_access.json
  }
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "ssm_user"
  role = aws_iam_role.allow_s3_access.name
}
