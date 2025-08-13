resource "aws_ebs_volume" "main" {
  type = "gp3"
  size = var.volume_size
  tags = {
    "Name" = var.Name
  }
  encrypted         = false
  availability_zone = "ap-northeast-1d"
}

resource "aws_volume_attachment" "dev_sda1" {
  device_name = "/dev/sda1"
  volume_id   = aws_ebs_volume.main.id
  instance_id = aws_instance.main.id
}
