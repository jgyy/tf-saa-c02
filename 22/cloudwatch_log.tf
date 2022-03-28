resource "aws_cloudwatch_log_metric_filter" "yada" {
  name           = "DemoFilter"
  pattern        = "installing"
  log_group_name = aws_cloudwatch_log_group.dada.name

  metric_transformation {
    name      = "DemoMetricFilter"
    namespace = "DemoMetricFilterNamespace"
    value     = "1"
  }
}

resource "aws_cloudwatch_log_group" "dada" {
  name = "demo-log-group"
}

resource "aws_cloudwatch_query_definition" "example" {
  name = "custom_query"

  log_group_names = [
    "/aws/logGroup1",
    "/aws/logGroup2"
  ]

  query_string = <<EOF
fields @timestamp, @message
| sort @timestamp desc
| limit 20
EOF
}
