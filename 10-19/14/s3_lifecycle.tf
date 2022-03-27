resource "aws_s3_bucket_lifecycle_configuration" "bucket-config" {
  bucket = aws_s3_bucket.storage.bucket

  rule {
    id     = "DemoRule"
    status = "Enabled"
    expiration { days = 700 }
    filter {}

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    transition {
      days          = 70
      storage_class = "INTELLIGENT_TIERING"
    }
    transition {
      days          = 180
      storage_class = "GLACIER"
    }
    transition {
      days          = 365
      storage_class = "DEEP_ARCHIVE"
    }

    noncurrent_version_transition {
      noncurrent_days = 60
      storage_class   = "GLACIER"
    }
  }
}
