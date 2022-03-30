resource "aws_kms_key" "tutorial" {
  description             = "tutorial"
  deletion_window_in_days = 10
}

resource "aws_kms_alias" "tutorial" {
  name          = "alias/tutorial"
  target_key_id = aws_kms_key.tutorial.key_id
}
