resource "aws_lb" "demo-nlb" {
  name                             = "DemoNLB"
  internal                         = false
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = true
  subnets                          = [for subnet in data.aws_subnets.abc.ids : subnet]

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "nlb-listener" {
  load_balancer_arn = aws_lb.demo-nlb.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb-target.arn
  }
}

resource "aws_lb_target_group" "nlb-target" {
  name     = "my-nlb-target-group"
  port     = 80
  protocol = "TCP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    healthy_threshold   = 3
    interval            = 10
  }
}

resource "aws_lb_target_group_attachment" "nlb-web1" {
  target_group_arn = aws_lb_target_group.nlb-target.arn
  target_id        = aws_instance.web1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "nlb-web2" {
  target_group_arn = aws_lb_target_group.nlb-target.arn
  target_id        = aws_instance.web2.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "nlb-web3" {
  target_group_arn = aws_lb_target_group.nlb-target.arn
  target_id        = aws_instance.web3.id
  port             = 80
}
