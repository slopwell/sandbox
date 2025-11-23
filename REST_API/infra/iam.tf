resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
      {
        "Sid"    = "",
        "Effect" = "Allow",
        "Principal" = {
          "Service" = "apigateway.amazonaws.com"
        },
        "Action" = "sts:AssumeRole"
      }
    ]
  })

  inline_policy {
    name = "dynamodb"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "dynamodb:GetItem",
            "dynamodb:PutItem",
            "dynamodb:Scan",
            "dynamodb:UpdateItem"
          ]
          Effect = "Allow"
          Resource = [
            "${aws_dynamodb_table.dogs_table.arn}",
            "${aws_dynamodb_table.dogs_table.arn}/*",
            "*"
          ]
        },
        {
          Effect   = "Allow"
          Action   = "lambda:InvokeFunction",
          Resource = "*"
        }
      ]
    })
  }

  inline_policy {
    name = "rekognition"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "rekognition:CreateCollection",
            "rekognition:DeleteCollection",
            "rekognition:IndexFaces",
            "rekognition:ListCollections",
            "rekognition:SearchFacesByImage",
            "rekognition:DetectText"
          ]
          Effect   = "Allow"
          Resource = "*"
        }
      ]
    })
  }

  inline_policy {
    name = "s3"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "s3:GetObject",
            "s3:PutObject"
          ]
          Effect   = "Allow"
          Resource = "*"
        }
      ]
    })
  }
}

resource "aws_iam_role_policy_attachment" "lambda_invocation_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSLambdaInvocation-DynamoDB"
}
