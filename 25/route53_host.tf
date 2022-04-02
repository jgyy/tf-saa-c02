resource "aws_route53_zone" "private" {
  name = "demo.internal"
  vpc {
    vpc_id = aws_vpc.main.id
  }
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "google.demo.internal"
  type    = "CNAME"
  ttl     = "300"
  records = ["www.google.com"]
}
