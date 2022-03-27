resource "aws_s3_bucket" "b" {
  bucket        = "demo-jgyy-mfa-delete-2022"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.b.id
  versioning_configuration {
    status = "Enabled"
  }
}
