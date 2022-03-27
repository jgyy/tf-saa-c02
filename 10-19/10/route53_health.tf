resource "aws_route53_health_check" "singapore" {
  ip_address        = aws_instance.singapore.public_ip
  port              = 80
  type              = "HTTP"
  resource_path     = "/"
  failure_threshold = "5"
  request_interval  = "30"
  tags = {
    Name = "singapore"
  }
}

resource "aws_route53_health_check" "sydney" {
  ip_address        = aws_instance.sydney.public_ip
  port              = 80
  type              = "HTTP"
  resource_path     = "/"
  failure_threshold = "5"
  request_interval  = "30"
  tags = {
    Name = "sydney"
  }
}

resource "aws_route53_health_check" "tokyo" {
  ip_address        = aws_instance.tokyo.public_ip
  port              = 80
  type              = "HTTP"
  resource_path     = "/"
  failure_threshold = "5"
  request_interval  = "30"
  tags = {
    Name = "tokyo"
  }
}

resource "aws_route53_health_check" "parent" {
  type                   = "CALCULATED"
  child_health_threshold = 3
  child_healthchecks = [
    aws_route53_health_check.singapore.id,
    aws_route53_health_check.sydney.id,
    aws_route53_health_check.tokyo.id
  ]
  tags = {
    Name = "tf-test-calculated-health-check"
  }
}
