resource "aws_subnet" "main" {
  availability_zone = var.az
  vpc_id            = aws_vpc.main.id
  cidr_block        = aws_vpc.main.cidr_block

  private_dns_hostname_type_on_launch = "ip-name"

  tags = {
    Name = var.Name
  }

}
