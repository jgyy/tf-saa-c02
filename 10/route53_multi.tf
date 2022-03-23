resource "aws_route53_record" "multi-singapore" {
  zone_id                          = aws_route53_zone.primary.zone_id
  name                             = "multi.jgyycom.com"
  type                             = "A"
  ttl                              = "60"
  records                          = [aws_instance.singapore.public_ip]
  set_identifier                   = "multivalue-singapore"
  health_check_id                  = aws_route53_health_check.singapore.id
  multivalue_answer_routing_policy = true
}

resource "aws_route53_record" "multi-sydney" {
  zone_id                          = aws_route53_zone.primary.zone_id
  name                             = "multi.jgyycom.com"
  type                             = "A"
  ttl                              = "60"
  records                          = [aws_instance.sydney.public_ip]
  set_identifier                   = "multivalue-sydney"
  health_check_id                  = aws_route53_health_check.sydney.id
  multivalue_answer_routing_policy = true
}

resource "aws_route53_record" "multi-tokyo" {
  zone_id                          = aws_route53_zone.primary.zone_id
  name                             = "multi.jgyycom.com"
  type                             = "A"
  ttl                              = "60"
  records                          = [aws_instance.tokyo.public_ip]
  set_identifier                   = "multivalue-tokyo"
  health_check_id                  = aws_route53_health_check.tokyo.id
  multivalue_answer_routing_policy = true
}
