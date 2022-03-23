resource "aws_route53_record" "failover-tokyo" {
  zone_id         = aws_route53_zone.primary.zone_id
  name            = "failover.jgyycom.com"
  type            = "A"
  ttl             = "60"
  records         = [aws_instance.tokyo.public_ip]
  set_identifier  = "failover-tokyo"
  health_check_id = aws_route53_health_check.singapore.id
  failover_routing_policy {
    type = "PRIMARY"
  }
}

resource "aws_route53_record" "failover-sydney" {
  zone_id         = aws_route53_zone.primary.zone_id
  name            = "failover.jgyycom.com"
  type            = "A"
  ttl             = "60"
  records         = [aws_instance.sydney.public_ip]
  set_identifier  = "failover-sydney"
  health_check_id = aws_route53_health_check.tokyo.id
  failover_routing_policy {
    type = "SECONDARY"
  }
}
