resource "aws_route53_record" "weighted-singapore" {
  zone_id         = aws_route53_zone.primary.zone_id
  name            = "weighted.jgyycom.com"
  type            = "A"
  ttl             = "3"
  set_identifier  = "weighted-singapore"
  records         = [aws_instance.singapore.public_ip]
  health_check_id = aws_route53_health_check.singapore.id
  weighted_routing_policy {
    weight = 10
  }
}

resource "aws_route53_record" "weighted-sydney" {
  zone_id         = aws_route53_zone.primary.zone_id
  name            = "weighted.jgyycom.com"
  type            = "A"
  ttl             = "3"
  set_identifier  = "weighted-sydney"
  records         = [aws_instance.sydney.public_ip]
  health_check_id = aws_route53_health_check.sydney.id
  weighted_routing_policy {
    weight = 70
  }
}

resource "aws_route53_record" "weighted-tokyo" {
  zone_id         = aws_route53_zone.primary.zone_id
  name            = "weighted.jgyycom.com"
  type            = "A"
  ttl             = "3"
  set_identifier  = "weighted-tokyo"
  records         = [aws_instance.tokyo.public_ip]
  health_check_id = aws_route53_health_check.tokyo.id
  weighted_routing_policy {
    weight = 20
  }
}

resource "aws_route53_record" "latency-singapore" {
  zone_id         = aws_route53_zone.primary.zone_id
  name            = "latency.jgyycom.com"
  type            = "A"
  ttl             = "300"
  set_identifier  = "latency-singapore"
  records         = [aws_instance.singapore.public_ip]
  health_check_id = aws_route53_health_check.singapore.id
  latency_routing_policy {
    region = "ap-southeast-1"
  }
}

resource "aws_route53_record" "latency-sydney" {
  zone_id         = aws_route53_zone.primary.zone_id
  name            = "latency.jgyycom.com"
  type            = "A"
  ttl             = "300"
  set_identifier  = "latency-sydney"
  records         = [aws_instance.sydney.public_ip]
  health_check_id = aws_route53_health_check.sydney.id
  latency_routing_policy {
    region = "ap-southeast-2"
  }
}

resource "aws_route53_record" "latency-tokyo" {
  zone_id         = aws_route53_zone.primary.zone_id
  name            = "latency.jgyycom.com"
  type            = "A"
  ttl             = "300"
  set_identifier  = "latency-tokyo"
  records         = [aws_instance.tokyo.public_ip]
  health_check_id = aws_route53_health_check.tokyo.id
  latency_routing_policy {
    region = "ap-northeast-1"
  }
}
