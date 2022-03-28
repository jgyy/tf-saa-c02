data "aws_caller_identity" "current" {}

resource "aws_cloudtrail" "foobar" {
  name                          = "DemoTrail"
  s3_bucket_name                = aws_s3_bucket.foo.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = false
  enable_log_file_validation    = true
  depends_on = [
    aws_s3_bucket.foo,
    aws_s3_bucket_policy.cloudtrail
  ]

  event_selector {
    read_write_type           = "All"
    include_management_events = true
  }
}

resource "aws_cloudwatch_log_group" "example" {
  name = "aws-cloudtrail-logs"
}

resource "aws_athena_database" "example" {
  name   = "database_name"
  bucket = aws_s3_bucket.foo.bucket
}
