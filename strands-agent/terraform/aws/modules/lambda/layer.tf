resource "aws_lambda_layer_version" "my_layer" {
  filename            = var.layer_filename
  layer_name          = "${var.namespace}_${var.function_name}_layer"
  compatible_runtimes = [var.runtime]
  description         = "Python dependencies for my_agent"
}
