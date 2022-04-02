data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_elb" "bar" {
  name                        = "my-demo-clb"
  availability_zones          = [for az in data.aws_availability_zones.available.ids : az]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
  security_groups             = [aws_security_group.lb.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 4
    target              = "HTTP:80/index.html"
    interval            = 5
  }

  tags = {
    Name = "my-demo-clb"
  }
}

resource "aws_elb_attachment" "attacha" {
  elb      = aws_elb.bar.id
  instance = aws_instance.web1.id
}

resource "aws_elb_attachment" "attachb" {
  elb      = aws_elb.bar.id
  instance = aws_instance.web2.id
}

resource "aws_elb_attachment" "attachc" {
  elb      = aws_elb.bar.id
  instance = aws_instance.web3.id
}
