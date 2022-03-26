resource "aws_sqs_queue" "demo" {
  name                       = "DemoQueue"
  visibility_timeout_seconds = 5

  redrive_policy = jsonencode({
    deadLetterTargetArn = "${aws_sqs_queue.letter.arn}"
    maxReceiveCount     = 3
  })
  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = ["${aws_sqs_queue.letter.arn}"]
  })
}

resource "aws_sqs_queue" "s3" {
  name                       = "EventFromS3"
  visibility_timeout_seconds = 64
}

resource "aws_sqs_queue" "letter" {
  name                      = "DemoQueueDLQ"
  message_retention_seconds = 1209600
}

resource "aws_sqs_queue" "delay" {
  name          = "DelayQueue"
  delay_seconds = 10
}

resource "aws_sqs_queue" "terraform_queue" {
  name                        = "DemoQueue.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}