resource "aws_vpc" "dmz_vpc" {
  cidr_block                       = "10.100.0.0/16"
  enable_dns_hostnames             = true
  enable_dns_support               = true
  assign_generated_ipv6_cidr_block = false

  tags = {
    Name = "slopwell-sandbox_dmz"
    env  = "slopwell-sandbox"
  }
}

resource "aws_internet_gateway" "dmz" {
  vpc_id = aws_vpc.dmz_vpc.id

  tags = {
    Name = "slopwell-sandbox_dmz"
    env  = "slopwell-sandbox"
  }
}

resource "aws_route_table" "dmz" {
  vpc_id = aws_vpc.dmz_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dmz.id
  }
  route {
    cidr_block                = aws_vpc.main.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
  }

  tags = {
    Name = "slopwell-sandbox_vpc-dmz"
    env  = "slopwell-sandbox"
  }
}

# Transit-GWのべスプラは/28
resource "aws_subnet" "tokyo_a_dmz" {
  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.100.255.0/28"
  vpc_id            = aws_vpc.dmz_vpc.id

  tags = {
    Name = "slopwell-sandbox_dmz"
    env  = "slopwell-sandbox"
  }
}


