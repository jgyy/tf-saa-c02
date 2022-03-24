resource "aws_s3_object" "beach" {
  bucket = aws_s3_bucket.b.id
  key    = "beach.jpg"
  source = "${path.module}/website/beach.jpg"
}

resource "aws_s3_object" "coffee" {
  bucket = aws_s3_bucket.b.id
  key    = "coffee.jpg"
  source = "${path.module}/website/coffee.jpg"
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.b.id
  key    = "error.html"
  source = "${path.module}/website/error.html"
}

resource "aws_s3_object" "extra" {
  bucket = aws_s3_bucket.b.id
  key    = "extra-page.html"
  source = "${path.module}/website/extra-page.html"
}

resource "aws_s3_object" "extra2" {
  bucket = aws_s3_bucket.b2.id
  key    = "extra-page.html"
  source = "${path.module}/website/extra-page.html"
}

resource "aws_s3_object" "index-fetch" {
  bucket = aws_s3_bucket.b.id
  key    = "index-with-fetch.html"
  source = "${path.module}/website/index-with-fetch.html"
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.b.id
  key    = "index.html"
  source = "${path.module}/website/index.html"
}
