resource "aws_ssm_parameter" "dev-url" {
  name        = "/myapp/dev/db-url"
  type        = "String"
  value       = "dev.database.jgyycom.com:3306"
  description = "Database URL for my app in development"
}

resource "aws_ssm_parameter" "dev-password" {
  name        = "/myapp/dev/db-password"
  type        = "SecureString"
  key_id      = aws_kms_key.tutorial.id
  value       = "thisisthedevpassword"
  description = "Database Password for my app in development"
}

resource "aws_ssm_parameter" "prod-url" {
  name        = "/myapp/prod/db-url"
  type        = "String"
  value       = "prod.database.jgyycom.com:3306"
  description = "Database URL for my app in production"
}

resource "aws_ssm_parameter" "prod-password" {
  name        = "/myapp/prod/db-password"
  type        = "SecureString"
  key_id      = aws_kms_key.tutorial.id
  value       = "thisistheprodpassword"
  description = "Database Password for my app in production"
}