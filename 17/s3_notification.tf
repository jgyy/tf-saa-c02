resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.b.id
  queue {
    id        = "NewObjects"
    queue_arn = aws_sqs_queue.s3.arn
    events    = ["s3:ObjectCreated:*"]
  }
}
