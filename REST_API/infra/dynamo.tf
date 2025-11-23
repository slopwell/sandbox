resource "aws_dynamodb_table" "dogs_table" {
  name           = "dogs_table"
  hash_key       = "id"
  range_key      = "name"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1

  attribute {
    name = "id"
    type = "S"
  }
  attribute {
    name = "name"
    type = "S"
  }

  global_secondary_index {
    name            = "name-index"
    hash_key        = "name"
    projection_type = "ALL"
    write_capacity  = 1
    read_capacity   = 1
  }
}
