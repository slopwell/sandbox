
resource "aws_instance" "main" {
  ami                                  = data.aws_ami.ws_2016_nano.id
  availability_zone                    = "ap-northeast-1d"
  iam_instance_profile                 = var.instance_profile_name
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = var.itype
  # @REVIEW TFM的にkey pairはどう扱うのがいいのかな
  # key_name                             = "Staff-V"
  user_data_replace_on_change = false
  tags = {
    "Name"  = var.Name
    "itype" = var.itype
    "env"   = var.env
    "gen"   = "slopwell-sandbox"
  }

  credit_specification {
    cpu_credits = "standard"
  }

  maintenance_options {
    auto_recovery = "default"
  }

  network_interface {
    network_interface_id = aws_network_interface.main.id
    device_index         = 0
  }

  root_block_device {
    volume_size           = var.volume_size
    delete_on_termination = false
    tags = {
      Name = var.Name
    }
  }
}
