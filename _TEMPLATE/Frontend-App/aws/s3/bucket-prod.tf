resource "aws_s3_bucket" "host_prod" {
  bucket = "${var.namespace}-host-prod"
}
