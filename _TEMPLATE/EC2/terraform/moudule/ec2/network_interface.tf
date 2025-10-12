resource "aws_network_interface" "main" {
  subnet_id         = var.subnet_id
  description       = "Primary NIF"
  private_ips_count = 0

  security_groups = [aws_security_group.instance_sg.id]

  source_dest_check = true
  tags = {
    Name = var.Name
  }
}
