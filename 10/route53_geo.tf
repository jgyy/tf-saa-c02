resource "aws_route53_record" "geo-singapore" {
  zone_id         = aws_route53_zone.primary.zone_id
  name            = "geo.jgyycom.com"
  type            = "A"
  ttl             = "300"
  records         = [aws_instance.singapore.public_ip]
  set_identifier  = "geolocation-singapore"
  health_check_id = aws_route53_health_check.singapore.id
  geolocation_routing_policy {
    country = "*"
  }
}

resource "aws_route53_record" "geo-sydney" {
  zone_id         = aws_route53_zone.primary.zone_id
  name            = "geo.jgyycom.com"
  type            = "A"
  ttl             = "300"
  records         = [aws_instance.sydney.public_ip]
  set_identifier  = "geolocation-sydney"
  health_check_id = aws_route53_health_check.sydney.id
  geolocation_routing_policy {
    country = "AU"
  }
}

resource "aws_route53_record" "geo-tokyo" {
  zone_id         = aws_route53_zone.primary.zone_id
  name            = "geo.jgyycom.com"
  type            = "A"
  ttl             = "300"
  records         = [aws_instance.tokyo.public_ip]
  set_identifier  = "geolocation-tokyo"
  health_check_id = aws_route53_health_check.tokyo.id
  geolocation_routing_policy {
    country = "JP"
  }
}
