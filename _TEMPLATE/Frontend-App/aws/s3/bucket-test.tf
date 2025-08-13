resource "aws_s3_bucket" "host_test" {
  bucket = "${var.namespace}-host-test"
}
