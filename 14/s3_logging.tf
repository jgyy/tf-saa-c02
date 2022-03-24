resource "aws_s3_bucket" "log_bucket" {
  bucket        = "demo-s3-access-logs-jgyy-2022"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "log_bucket_acl" {
  bucket = aws_s3_bucket.log_bucket.id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket_logging" "example" {
  bucket = aws_s3_bucket.b.id

  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "s3-logs/"
}
