locals {
  ip_protocl_all = "-1"
}

resource "aws_security_group" "instance_sg" {
  name        = var.Name
  description = var.Name
  tags = {
    Name = var.Name
  }

  egress {
    description      = ""
    from_port        = 0
    to_port          = 0
    protocol         = local.ip_protocl_all
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

# inboud rule
# @REVIEW 無制限なので要確認
# ---------------------------------------------------------------
resource "aws_vpc_security_group_ingress_rule" "inbound_rule" {
  security_group_id = aws_security_group.instance_sg.id
  cidr_ipv4         = var.inbound_cidr
  ip_protocol       = local.ip_protocl_all
  description       = ""
}
