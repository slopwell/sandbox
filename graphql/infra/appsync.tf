locals {
  name = "my-gql"
}

data "localfile" "graphql_schema" {
  filename = "./backend/src/schema/schema.graphql"
}

resource "aws_appsync_graphql_api" "my_gql" {
  authentication_type = "API_KEY"
  name                = local.name
  schema              = data.localfile.graphql_schema.content
}

resource "aws_appsync_api_key" "my_gql" {
  api_id = aws_appsync_graphql_api.my_gql.id
}

resource "aws_appsync_datasource" "my_gql" {
  api_id           = aws_appsync_graphql_api.my_gql.id
  name             = "my_gql"
  service_role_arn = aws_iam_role.my_gql.arn
  type             = "AMAZON_DYNAMODB"

  dynamodb_config {
    table_name = aws_dynamodb_table.cats_table.name
  }
}
