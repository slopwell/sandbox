resource "aws_eip" "main" {
  domain               = "vpc"
  network_border_group = "ap-northeast-1"
  public_ipv4_pool     = "amazon"
  instance             = aws_instance.main.id
  network_interface    = aws_network_interface.main.id
}
