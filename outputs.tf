output "secret_arn" {
  description = "ARN of the created secret which holds the database credentials."
  value       = aws_secretsmanager_secret.database_credentials.arn
}

output "secret_id" {
  description = "ID of the created secret which holds the database credentials."
  value       = aws_secretsmanager_secret.database_credentials.id
}
