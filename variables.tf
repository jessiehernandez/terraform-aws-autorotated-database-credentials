# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# ------------------------------------------------------------------------------

variable "db_engine" {
  description = "Database engine (only 'postgres' and 'sqlserver' are supported)."
  type        = string
}

variable "db_host" {
  description = "Database host."
  type        = string
}

variable "db_initial_password" {
  description = "Initial password for the database. Will be rotated immediately after the secret is created."
  type        = string
}

variable "db_name" {
  description = "Database name."
  type        = string
}

variable "db_username" {
  description = "Database username."
  type        = string
}

variable "rotation_lambda_arn" {
  description = "ARN to the rotation Lambda function."
  type        = string
}

variable "secret_description" {
  description = "Description of the Secrets Manager secret that will store the DB credentials."
  type        = string
}

variable "secret_name" {
  description = "Name to use for the Secrets Manager secret that will store the DB credentials."
  type        = string
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# ------------------------------------------------------------------------------

variable "db_instance" {
  default     = ""
  description = "Database instance name (only used for 'sqlserver' databases)."
  type        = string
}

variable "db_port" {
  default     = ""
  description = "Database port."
  type        = string
}

variable "kms_key_id" {
  default     = null
  description = "ARN or ID of the CMK to be used to encrypt the secret value. If not specified, the default is used."
  type        = string
}

variable "rotation_interval" {
  default     = 30
  description = "The number of days between automatic scheduled rotations of the secret."
  type        = number
}

variable "tags" {
  default     = {}
  description = "Tags to apply to created resources."
  type        = map(string)
}
