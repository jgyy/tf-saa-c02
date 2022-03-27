resource "aws_route53_zone" "primary" {
  name = "jgyycom.com"
}

resource "aws_route53_record" "test" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "test.jgyycom.com"
  type    = "A"
  ttl     = "300"
  records = ["11.22.33.44"]
}

resource "aws_route53_record" "demo" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "demo.jgyycom.com"
  type    = "A"
  ttl     = "120"
  records = [aws_instance.singapore.public_ip]
}

resource "aws_route53_record" "myapp" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "myapp.jgyycom.com"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_lb.alb.dns_name]
}

resource "aws_route53_record" "myalias" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "myalias.jgyycom.com"
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "null" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "jgyycom.com"
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "simple" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "simple.jgyycom.com"
  type    = "A"
  ttl     = "20"
  records = [aws_instance.singapore.public_ip, aws_instance.sydney.public_ip]
}
