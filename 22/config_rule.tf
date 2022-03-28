resource "aws_config_config_rule" "r" {
  name        = "restricted-ssh"
  description = "Check whether security groups that are in use disallow unrestricted incoming ssh traffic."
  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_VERSIONING_ENABLED"
  }
  depends_on = [aws_config_configuration_recorder.ssh]
}

resource "aws_config_configuration_recorder" "ssh" {
  name     = "example"
  role_arn = aws_iam_role.r.arn
}
