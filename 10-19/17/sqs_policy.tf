data "aws_caller_identity" "current" {}

resource "aws_sqs_queue_policy" "demo" {
  queue_url = aws_sqs_queue.demo.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Id" : "sqspolicy",
    "Statement" : [
      {
        "Sid" : "First",
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "sqs:*",
        "Resource" : "${aws_sqs_queue.demo.arn}"
      }
    ]
  })
}

resource "aws_sqs_queue_policy" "queue_policy" {
  queue_url = aws_sqs_queue.s3.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "s3.amazonaws.com"
        },
        "Action" : "SQS:SendMessage",
        "Resource" : "${aws_sqs_queue.s3.arn}",
        "Condition" : {
          "StringEquals" : {
            "aws:SourceAccount" : "${data.aws_caller_identity.current.id}"
          },
          "ArnLike" : {
            "aws:SourceArn" : "${aws_s3_bucket.b.arn}"
          }
        }
      }
    ]
  })
}
