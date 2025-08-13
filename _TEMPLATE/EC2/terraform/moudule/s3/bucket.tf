resource "aws_s3_bucket" "ssm_bucket" {
  bucket = var.Name

  tags = {
    Name = var.Name
  }
}
