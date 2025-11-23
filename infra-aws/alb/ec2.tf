data "aws_s3_bucket" "slopwell-sandbox" {
  bucket = "slopwell-sandbox"
}

module "iam" {
  source        = "../moudule/iam"
  Name          = "slopwell-sandbox"
  s3_bucket_arn = data.aws_s3_bucket.slopwell-sandbox.arn
}

data "aws_ami" "amzn_linux_2023" {
  owners = ["amazon"]

  most_recent = true

  filter {
    name   = "image-id"
    values = ["ami-0f9fe1d9214628296"]
  }
}

resource "aws_key_pair" "slopwell-sandbox" {
  key_name   = "slopwell-sandbox_key_pair"
  public_key = file("./ssh/example.id_rsa.pub")
}

# tokyo a private subnet
resource "aws_instance" "app1" {
  ami                  = data.aws_ami.amzn_linux_2023.id
  availability_zone    = "ap-northeast-1a"
  iam_instance_profile = module.iam.instance_profile_name
  instance_type        = "t3.micro"
  subnet_id            = aws_subnet.tokyo_a_private.id

  instance_initiated_shutdown_behavior = "stop"

  # @REVIEW TFM的にkey pairはどう扱うのがいいのかな
  key_name                    = aws_key_pair.slopwell-sandbox.key_name
  user_data_replace_on_change = false
  tags = {
    "Name"  = "slopwell-sandbox-ec2-app1"
    "itype" = "t3.micro"
    "env"   = "slopwell-sandbox"
    "gen"   = "slopwell-sandbox-terraform"
  }

  credit_specification {
    cpu_credits = "standard"
  }

  maintenance_options {
    auto_recovery = "default"
  }

  # network_interface {
  #   network_interface_id = aws_network_interface.main.id
  #   device_index         = 0
  # }

  root_block_device {
    volume_type           = "gp3"
    volume_size           = "8"
    delete_on_termination = false

    # encrypted  = var.use_encrypted_volumes
    # kms_key_id = var.use_encrypted_volumes ? aws_kms_key.main.arn : null

    tags = {
      "Name" = "slopwell-sandbox-ec2"
    }
  }
}


# tokyo c private subnet
resource "aws_instance" "app2" {
  ami                  = data.aws_ami.amzn_linux_2023.id
  availability_zone    = "ap-northeast-1c"
  iam_instance_profile = module.iam.instance_profile_name
  instance_type        = "t3.micro"
  subnet_id            = aws_subnet.tokyo_c_private.id

  instance_initiated_shutdown_behavior = "stop"

  # @REVIEW TFM的にkey pairはどう扱うのがいいのかな
  key_name                    = aws_key_pair.slopwell-sandbox.key_name
  user_data_replace_on_change = false
  tags = {
    "Name"  = "slopwell-sandbox-ec2-app2"
    "itype" = "t3.micro"
    "env"   = "slopwell-sandbox"
    "gen"   = "slopwell-sandbox-terraform"
  }

  credit_specification {
    cpu_credits = "standard"
  }

  maintenance_options {
    auto_recovery = "default"
  }

  # network_interface {
  #   network_interface_id = aws_network_interface.main.id
  #   device_index         = 0
  # }

  root_block_device {
    volume_type           = "gp3"
    volume_size           = "8"
    delete_on_termination = false

    # encrypted  = var.use_encrypted_volumes
    # kms_key_id = var.use_encrypted_volumes ? aws_kms_key.main.arn : null

    tags = {
      "Name" = "slopwell-sandbox-ec2"
    }
  }
}
