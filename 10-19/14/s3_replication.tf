resource "aws_s3_bucket" "destination" {
  provider = aws.sydney
  bucket   = "demo-jgyy-replica-2022"
}

resource "aws_s3_bucket_versioning" "destination" {
  provider = aws.sydney
  bucket   = aws_s3_bucket.destination.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "source" {
  bucket = "demo-jgyy-origin-2022"
}

resource "aws_s3_bucket_acl" "source_bucket_acl" {
  bucket = aws_s3_bucket.source.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "source" {
  bucket = aws_s3_bucket.source.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_replication_configuration" "replication" {
  role   = aws_iam_role.replication.arn
  bucket = aws_s3_bucket.source.id
  depends_on = [
    aws_s3_bucket_versioning.source,
    aws_s3_bucket_versioning.destination
  ]
  rule {
    id     = "DemoRule"
    status = "Enabled"
    destination {
      bucket        = aws_s3_bucket.destination.arn
      storage_class = "STANDARD"
    }
  }
}
