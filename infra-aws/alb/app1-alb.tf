resource "aws_security_group" "alb_sg" {
  description = "slopwell-sandbox_dummy-vwifi"
  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  ]
  ingress = [
    {
      cidr_blocks = [
        "${local.vwifi}/32",
      ]
      description      = "dummy-vwifi"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  ]
  name = "slopwell-sandbox_dummy-vwifi"
  tags = {
    "Name" = "slopwell-sandbox_dummy-vwifi"
  }
  vpc_id = aws_vpc.main.id
}

# ALBの定義
resource "aws_lb" "app1_alb" {
  name               = "das"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets = [
    aws_subnet.tokyo_a_public.id,
    aws_subnet.tokyo_c_public.id
  ]

  tags = {
    Name = "slopwell-sandbox_alb"
  }
}

# ターゲットグループの定義
resource "aws_lb_target_group" "app1" {
  name     = "slopwell-sandbox-target-group"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = aws_vpc.main.id

  health_check {
    enabled             = true
    healthy_threshold   = 5
    interval            = 30
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  stickiness {
    cookie_duration = 86400
    enabled         = false
    type            = "lb_cookie"
  }

  tags = {
    Name = "slopwell-sandbox_target_group"
  }
}

# リスナーの定義
resource "aws_lb_listener" "app1" {
  load_balancer_arn = aws_lb.app1_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app1.arn
  }

  tags = {
    Name = "slopwell-sandbox_alb_listener"
  }
}

# リスナールールの定義
resource "aws_lb_listener_rule" "app1" {
  listener_arn = aws_lb_listener.app1.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app1.arn
  }

  condition {
    host_header {
      values = ["www1.ex.com"]
    }
  }

  tags = {
    Name = "w1"
  }
}
