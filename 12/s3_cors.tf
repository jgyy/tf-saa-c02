resource "aws_s3_bucket_cors_configuration" "example" {
  bucket = aws_s3_bucket.b2.bucket

  cors_rule {
    allowed_headers = ["Authorization"]
    allowed_methods = ["GET"]
    allowed_origins = [
      aws_s3_bucket.b2.bucket_regional_domain_name,
      aws_s3_bucket.b2.bucket_domain_name
    ]
    expose_headers  = []
    max_age_seconds = 3000
  }
}
