resource "aws_s3_bucket" "storage" {
  bucket = "demo-jgyy-2022-storage-classes"
}

resource "aws_s3_bucket_versioning" "storage-version" {
  bucket = aws_s3_bucket.storage.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_object" "storage-beach" {
  bucket        = aws_s3_bucket.storage.id
  key           = "beach.jpg"
  source        = "${path.module}/beach.jpg"
  storage_class = "STANDARD_IA"
}

resource "aws_s3_object" "storage-coffee" {
  bucket        = aws_s3_bucket.storage.id
  key           = "beach.jpg"
  source        = "${path.module}/coffee.jpg"
  storage_class = "GLACIER"
}