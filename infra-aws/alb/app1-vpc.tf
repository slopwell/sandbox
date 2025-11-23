resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "slopwell-sandbox_vpc-vpc"
    env  = "slopwell-sandbox"
  }
}


resource "aws_route_table" "tokyo_any_public" {
  vpc_id = aws_vpc.main.id

  # route {
  #   cidr_block = "0.0.0.0/0"
  #   gateway_id = aws_internet_gateway.gw.id
  # }

  tags = {
    Name = "slopwell-sandbox_vpc-rtb-public"
    env  = "slopwell-sandbox"
  }
}

resource "aws_route_table" "vpc" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block                = aws_vpc.dmz_vpc.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
  }

  tags = {
    Name = "slopwell-sandbox_vpc-rtb-default"
    env  = "slopwell-sandbox"
  }
}

resource "aws_route_table" "tokyo_c_private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "slopwell-sandbox_vpc-rtb-private2-ap-northeast-1c"
    env  = "slopwell-sandbox"
  }
}

resource "aws_default_network_acl" "main" {
  default_network_acl_id = aws_vpc.main.default_network_acl_id

  subnet_ids = [
    aws_subnet.tokyo_a_public.id,
    aws_subnet.tokyo_c_public.id,
    aws_subnet.tokyo_a_private.id,
    aws_subnet.tokyo_c_private.id
  ]

  egress {
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    icmp_code  = 0
    icmp_type  = 0
    protocol   = "-1"
    rule_no    = 100
    to_port    = 0
  }

  ingress {
    action     = "allow"
    cidr_block = "${local.vwifi}/32"
    from_port  = 0
    icmp_code  = 0
    icmp_type  = 0
    protocol   = "-1"
    rule_no    = 100
    to_port    = 0
  }
}

resource "aws_subnet" "tokyo_a_public" {
  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.0.0/20"
  vpc_id            = aws_vpc.main.id

  tags = {
    Name = "slopwell-sandbox_vpc-subnet-public1-ap-northeast-1a"
    env  = "slopwell-sandbox"
  }
}

resource "aws_route_table" "tokyo_a_private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "slopwell-sandbox_vpc-rtb-private1-ap-northeast-1a"
    env  = "slopwell-sandbox"
  }
}

resource "aws_subnet" "tokyo_a_private" {
  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.128.0/20"
  vpc_id            = aws_vpc.main.id

  tags = {
    Name = "slopwell-sandbox_vpc-subnet-private1-ap-northeast-1a"
    env  = "slopwell-sandbox"
  }
}

resource "aws_subnet" "tokyo_c_private" {
  availability_zone = "ap-northeast-1c"
  cidr_block        = "10.0.144.0/20"
  vpc_id            = aws_vpc.main.id

  tags = {
    Name = "slopwell-sandbox_vpc-subnet-private2-ap-northeast-1c"
    env  = "slopwell-sandbox"
  }
}

resource "aws_subnet" "tokyo_c_public" {
  availability_zone = "ap-northeast-1c"
  cidr_block        = "10.0.16.0/20"
  vpc_id            = aws_vpc.main.id

  tags = {
    Name = "slopwell-sandbox_vpc-subnet-public2-ap-northeast-1c"
    env  = "slopwell-sandbox"
  }
}
