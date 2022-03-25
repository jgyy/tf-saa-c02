resource "aws_sqs_queue" "queue" {
  name = "demo-s3-notifications"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "sqs:SendMessage",
        "Resource" : "arn:aws:sqs:*:*:demo-s3-notifications",
        "Condition" : {
          "ArnEquals" : { "aws:SourceArn" : "${aws_s3_bucket.notify.arn}" }
        }
      }
    ]
  })
}

resource "aws_s3_bucket" "notify" {
  bucket = "demo-jgyy-2022-s3-bucket-notifications"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.notify.id

  queue {
    queue_arn = aws_sqs_queue.queue.arn
    events    = ["s3:ObjectCreated:*"]
  }
}

resource "aws_s3_object" "beach-notify" {
  bucket = aws_s3_bucket.notify.id
  key    = "beach.jpg"
  source = "${path.module}/beach.jpg"
}
