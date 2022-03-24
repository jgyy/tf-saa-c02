resource "aws_s3_bucket_policy" "access" {
  bucket = aws_s3_bucket.b.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "s3:GetObject"
        ],
        "Effect" : "Allow",
        "Resource" : "${aws_s3_bucket.b.arn}/*",
        "Principal" : "*"
      }
    ]
  })
}

resource "aws_s3_bucket_policy" "access2" {
  bucket = aws_s3_bucket.b2.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "s3:GetObject"
        ],
        "Effect" : "Allow",
        "Resource" : "${aws_s3_bucket.b.arn}/*",
        "Principal" : "*"
      }
    ]
  })
}
