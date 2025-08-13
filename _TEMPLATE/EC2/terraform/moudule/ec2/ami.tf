# AMIはlocalstack上にいい感じのがあるかを下記で調べて引っ張ってくる
# awslocal ec2 describe-images --filter Name=platform,Values=windows
data "aws_ami" "ws_2016_nano" {
  owners = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "name"
    values = ["Windows_Server-2016-English-Nano-Base-2017.10.13"]
  }
}
