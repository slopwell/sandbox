resource "aws_s3_bucket" "slopwell" {
  bucket = "slopwell"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
