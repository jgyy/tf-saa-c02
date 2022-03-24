resource "aws_s3_bucket_policy" "access" {
  bucket = aws_s3_bucket.b.id
  policy = jsonencode({
    "Id" : "Policy1648110961703",
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "Stmt1648110960615",
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
    "Id" : "Policy1648110961703",
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "Stmt1648110960615",
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
