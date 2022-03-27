resource "null_resource" "url" {
  provisioner "local-exec" {
    command = "aws s3 presign s3://${aws_s3_bucket.b.id}/${aws_s3_object.object.key} --expires-in 300"
  }
}
