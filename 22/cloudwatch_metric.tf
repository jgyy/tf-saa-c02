resource "null_resource" "cloudwatch" {
  provisioner "local-exec" {
    command = <<COMMAND
    aws cloudwatch put-metric-data \
    --metric-name Buffers \
    --namespace MyNameSpace \
    --unit Bytes \
    --value 231434333 \
    --dimensions InstanceID=1-23456789,InstanceType=m1.small
    COMMAND
  }
}
