resource "aws_s3_bucket" "b" {
  bucket = "demo-cloudfront-jgyy-v2"
}

resource "aws_s3_object" "beach" {
  bucket = aws_s3_bucket.b.id
  key    = "beach.jpg"
  source = "${path.module}/beach.jpg"
}

resource "aws_s3_object" "coffee" {
  bucket = aws_s3_bucket.b.id
  key    = "coffee.jpg"
  source = "${path.module}/coffee.jpg"
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.b.id
  key    = "index.html"
  source = "${path.module}/index.html"
}

resource "aws_s3_bucket_policy" "prod_website" {
  bucket = aws_s3_bucket.b.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "PublicReadGetObject",
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : [
          "s3:GetObject"
        ],
        "Resource" : [
          "arn:aws:s3:::${aws_s3_bucket.b.id}/*"
        ]
      }
    ]
  })
}
