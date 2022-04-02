data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "hoge" {
  bucket        = "demo-athena-jgyy-v2"
  force_destroy = true
}

resource "aws_kms_key" "test" {
  deletion_window_in_days = 7
  description             = "Athena KMS Key"
}

resource "aws_athena_workgroup" "test" {
  name = "example"

  configuration {
    result_configuration {
      encryption_configuration {
        encryption_option = "SSE_KMS"
        kms_key_arn       = aws_kms_key.test.arn
      }
    }
  }
}

resource "aws_athena_database" "hoge" {
  name   = "users"
  bucket = aws_s3_bucket.hoge.id
}

resource "aws_athena_named_query" "foo" {
  name      = "bar"
  workgroup = aws_athena_workgroup.test.id
  database  = aws_athena_database.hoge.name
  query     = <<QUERY
CREATE EXTERNAL TABLE IF NOT EXISTS `vpc_flow_logs` (
  `version` int, 
  `account_id` string, 
  `interface_id` string, 
  `srcaddr` string, 
  `dstaddr` string, 
  `srcport` int, 
  `dstport` int, 
  `protocol` bigint, 
  `packets` bigint, 
  `bytes` bigint, 
  `start` bigint, 
  `end` bigint, 
  `action` string, 
  `log_status` string, 
  `vpc_id` string, 
  `subnet_id` string, 
  `instance_id` string, 
  `tcp_flags` int, 
  `type` string, 
  `pkt_srcaddr` string, 
  `pkt_dstaddr` string, 
  `region` string, 
  `az_id` string, 
  `sublocation_type` string, 
  `sublocation_id` string, 
  `pkt_src_aws_service` string, 
  `pkt_dst_aws_service` string, 
  `flow_direction` string, 
  `traffic_path` int 
)
PARTITIONED BY (`date` date)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' '
LOCATION 's3://${aws_s3_bucket.hoge.id}/AWSLogs/${data.aws_caller_identity.current.account_id}/vpcflowlogs/ap-southeast-1/'
TBLPROPERTIES ("skip.header.line.count"="1");
ALTER TABLE vpc_flow_logs
ADD PARTITION (`date`='2022-04-01')
LOCATION 's3://${aws_s3_bucket.hoge.id}/AWSLogs/${data.aws_caller_identity.current.account_id}/vpcflowlogs/ap-southeast-1/2022/04/01';
SELECT * 
FROM vpc_flow_logs 
WHERE date = DATE('2022-05-04') 
LIMIT 100;
SELECT day_of_week(date) AS
  day,
  date,
  interface_id,
  srcaddr,
  action,
  protocol
FROM vpc_flow_logs
WHERE action = 'REJECT' AND protocol = 6
LIMIT 100;
SELECT SUM(numpackets) AS
  packetcount,
  dstaddr
FROM vpc_flow_logs
WHERE dstport = 443 AND date > current_date - interval '7' day
GROUP BY dstaddr
ORDER BY packetcount DESC
LIMIT 10;
QUERY
}
