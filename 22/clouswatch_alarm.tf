resource "aws_cloudwatch_metric_alarm" "foobar" {
  alarm_name                = "TerminateEC2OnHighCPU"
  comparison_operator       = "GreaterThanThreshold"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "95"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  evaluation_periods        = "3"
  datapoints_to_alarm       = "3"
  alarm_actions             = []
  insufficient_data_actions = []
}
