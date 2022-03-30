resource "aws_secretsmanager_secret" "example" {
  name                    = "/prod/my-secret-api"
  kms_key_id              = aws_kms_key.tutorial.id
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "example" {
  secret_id = aws_secretsmanager_secret.example.id
  secret_string = jsonencode({
    "API_KEY" : "secretvalueoftheAPIkey",
    "SECRET_KEY_API" : "2ndsecretvalue"
  })
}
