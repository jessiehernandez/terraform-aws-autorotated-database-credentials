resource "aws_secretsmanager_secret" "database_credentials" {
  description = var.secret_description
  kms_key_id  = var.kms_key_id
  name        = var.secret_name
  tags        = var.tags
}

resource "aws_secretsmanager_secret_rotation" "database_credentials" {
  rotation_lambda_arn = var.rotation_lambda_arn
  secret_id           = aws_secretsmanager_secret.database_credentials.id

  rotation_rules {
    automatically_after_days = var.rotation_interval
  }
}

resource "aws_secretsmanager_secret_version" "database_credentials" {
  secret_id     = aws_secretsmanager_secret.database_credentials.id
  secret_string = jsonencode({
    "dbname"   = var.db_name
    "engine"   = var.db_engine
    "host"     = var.db_host
    "instance" = var.db_instance
    "password" = var.db_initial_password # Password will be rotated immediately upon creation
    "port"     = var.db_port
    "username" = var.db_username
  })

  lifecycle {
    ignore_changes = [
      # Ignore changes to the credential info. After creation, any changes to
      # non-password fields should be made through the console to avoid issues
      # with Terraform resetting the password on the secret but not updating the
      # password on RDS.
      secret_string,
    ]
  }
}
