resource "aws_flow_log" "s3" {
  log_destination          = aws_s3_bucket.example.arn
  log_destination_type     = "s3"
  traffic_type             = "ALL"
  vpc_id                   = aws_vpc.main.id
  max_aggregation_interval = 60
  tags = {
    Name = "DemoS3FlowLog"
  }
}

resource "aws_s3_bucket" "example" {
  bucket        = "demo-jgyy-vpc-flow-logs-v2"
  force_destroy = true
}

resource "aws_flow_log" "cloudwatch" {
  iam_role_arn             = aws_iam_role.example.arn
  log_destination          = aws_cloudwatch_log_group.example.arn
  traffic_type             = "ALL"
  vpc_id                   = aws_vpc.main.id
  max_aggregation_interval = 60
  tags = {
    Name = "DemoFlowLogCWLogs"
  }
}

resource "aws_cloudwatch_log_group" "example" {
  name              = "VPCFlowLogs"
  retention_in_days = 1
}

resource "aws_iam_role" "example" {
  name = "example"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "vpc-flow-logs.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "example" {
  name = "example"
  role = aws_iam_role.example.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      }
    ]
  })
}
