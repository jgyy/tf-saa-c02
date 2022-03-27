resource "aws_lb" "alb" {
  name                       = "demo-alb-route-53"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.singapore.id]
  subnets                    = [for subnet in data.aws_subnets.singapore.ids : subnet]
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "alb-tg" {
  name        = "demo-tg-route-53"
  port        = 80
  protocol    = "TCP"
  vpc_id      = data.aws_vpc.singapore.id
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.alb-tg.arn
  target_id        = aws_instance.singapore.id
  port             = 80
}