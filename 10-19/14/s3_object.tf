resource "aws_kms_key" "examplekms" {
  description             = "KMS key 1"
  deletion_window_in_days = 7
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.b.id
  key    = "beach.jpg"
  source = "${path.module}/beach.jpg"
}

resource "aws_s3_object" "example" {
  bucket     = aws_s3_bucket.b.id
  kms_key_id = aws_kms_key.examplekms.arn
  source     = "${path.module}/coffee.jpg"
  key        = "coffee.jpg"
}

resource "aws_s3_object" "source-beach" {
  bucket = aws_s3_bucket.source.id
  key    = "beach.jpg"
  source = "${path.module}/beach.jpg"
}

resource "aws_s3_object" "source-coffee" {
  bucket = aws_s3_bucket.source.id
  key    = "coffee.jpg"
  source = "${path.module}/coffee.jpg"
}
