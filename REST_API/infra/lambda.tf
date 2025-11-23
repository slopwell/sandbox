# Lambda関数を作成するterraform
data "archive_file" "sample_zip" {
  type        = "zip"
  source_dir  = "./lambda/dist/functions/sample"
  output_path = "./lambda/dist/functions/sample.zip"
}

resource "aws_lambda_function" "sample" {
  function_name    = "slopwell_sample"
  memory_size      = 128
  timeout          = 3
  handler          = "index.handler"
  runtime          = "nodejs18.x"
  publish          = false
  role             = aws_iam_role.lambda_role.arn
  filename         = data.archive_file.sample_zip.output_path
  source_code_hash = data.archive_file.sample_zip.output_base64sha256
}
data "archive_file" "create_rekognition_collection_zip" {
  type        = "zip"
  source_dir  = "./lambda/dist/functions/create-rekognition-collection"
  output_path = "./lambda/dist/functions/create-rekognition-collection.zip"
}

resource "aws_lambda_function" "create_rekognition_collection" {
  function_name    = "slopwell_create_rekognition_collection"
  memory_size      = 128
  timeout          = 3
  handler          = "index.handler"
  runtime          = "nodejs18.x"
  publish          = false
  role             = aws_iam_role.lambda_role.arn
  filename         = data.archive_file.create_rekognition_collection_zip.output_path
  source_code_hash = data.archive_file.create_rekognition_collection_zip.output_base64sha256
}
data "archive_file" "detect_text_zip" {
  type        = "zip"
  source_dir  = "./lambda/dist/functions/detect-text"
  output_path = "./lambda/dist/functions/detect-text.zip"
}

resource "aws_lambda_function" "detect_text" {
  function_name    = "slopwell_detect_text"
  memory_size      = 128
  timeout          = 3
  handler          = "index.handler"
  runtime          = "nodejs18.x"
  publish          = false
  role             = aws_iam_role.lambda_role.arn
  filename         = data.archive_file.detect_text_zip.output_path
  source_code_hash = data.archive_file.detect_text_zip.output_base64sha256
}
