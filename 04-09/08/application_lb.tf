data "aws_subnets" "abc" {
  filter {
    name   = "tag:Name"
    values = ["Default Public 1a", "Default Public 1b", "Default Public 1c"]
  }
}

data "aws_vpc" "default" {
  filter {
    name   = "tag:Name"
    values = ["Default VPC"]
  }
}

resource "aws_lb" "demo-alb" {
  name                       = "DemoALB"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.lb.id]
  subnets                    = [for subnet in data.aws_subnets.abc.ids : subnet]

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.demo-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-target.arn
  }
}

resource "aws_lb_target_group" "alb-target" {
  name     = "my-alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 4
    interval            = 5
    matcher             = 200
  }

  stickiness {
    type = "lb_cookie"
  }
}

resource "aws_lb_target_group_attachment" "alb-web1" {
  target_group_arn = aws_lb_target_group.alb-target.arn
  target_id        = aws_instance.web1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "alb-web2" {
  target_group_arn = aws_lb_target_group.alb-target.arn
  target_id        = aws_instance.web2.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "alb-web3" {
  target_group_arn = aws_lb_target_group.alb-target.arn
  target_id        = aws_instance.web3.id
  port             = 80
}
