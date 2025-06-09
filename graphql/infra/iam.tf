data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["appsync.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "my_gql" {
  name               = "my_gql"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "my_gql" {
  statement {
    effect    = "Allow"
    actions   = ["dynamodb:*"]
    resources = [aws_dynamodb_table.cats_table.arn]
  }
}

resource "aws_iam_role_policy" "my_gql" {
  name   = "my_gql"
  role   = aws_iam_role.my_gql.id
  policy = data.aws_iam_policy_document.my_gql.json
}
