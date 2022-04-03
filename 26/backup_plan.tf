resource "aws_backup_plan" "example" {
  name = "TestPlan"

  rule {
    rule_name         = "tf_example_backup_rule"
    target_vault_name = aws_backup_vault.test.name
    schedule          = "cron(0 12 * * ? *)"
  }

  advanced_backup_setting {
    backup_options = {
      WindowsVSS = "enabled"
    }
    resource_type = "EC2"
  }
}

resource "aws_backup_vault" "test" {
  name        = "example_backup_vault"
  kms_key_arn = aws_kms_key.a.arn
}

resource "aws_kms_key" "a" {
  description             = "KMS key 1"
  deletion_window_in_days = 10
}

resource "aws_ebs_volume" "example" {
  availability_zone = "ap-southeast-1a"
  size              = 40

  tags = {
    Environment = "Production"
  }
}

resource "aws_backup_selection" "example" {
  iam_role_arn = aws_iam_role.example.arn
  name         = "TestAssignment"
  plan_id      = aws_backup_plan.example.id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "Environment"
    value = "Production"
  }
}
