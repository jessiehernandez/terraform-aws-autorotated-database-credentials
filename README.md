# Auto-rotated Database Credentials Module

This module creates a Secrets Manager secret that holds database credentials and
has a Lambda rotator function attached. The format of the secret that is created
is compatible with the format that the rotation function created by the
`database-credentials-rotator` module expects. Therefore, it is *highly*
recommended to use this module with the `database-credentials-rotator` module
instead of implementing your own rotator function.

## Contents

* [Inputs](#inputs)
* [Outputs](#outputs)
* [Usage](#usage)
* [Author(s)](#authors)

## Inputs

| Name                | Description                          | Type     | Default | Required |
|---------------------|--------------------------------------|----------|---------|----------|
| db_engine           | Database engine (`postgres` or `sqlserver`). | `string` |       | yes      |
| db_host             | Database host.                               | `string` |       | yes      |
| db_initial_password | Initial password for the database.           | `string` |       | yes      |
| db_instance         | Database instance name (only used for 'sqlserver' databases). | `string` | | no |
| db_name             | Database name.                               | `string` |       | yes      |
| db_port             | Database port.                               | `string` |       | no       |
| db_username         | Database username.                           | `string` |       | yes      |
| kms_key_id          | ARN or ID of the CMK to be used to encrypt the secret value. If not specified, the default is used. | `string` | `null` | no |
| rotation_interval   | The number of days between automatic scheduled rotations of the secret. | `number` | 30 | no |
| rotation_lambda_arn | ARN to the rotation Lambda function.         | `string` |       | yes      |
| secret_description  | Description of the Secrets Manager secret that will store the DB credentials. | `string` | | yes |
| secret_name         | Name to use for the Secrets Manager secret that will store the DB credentials. | `string` | | yes |

## Outputs

| Name       | Description                                                          |
|------------|----------------------------------------------------------------------|
| secret_arn | ARN of the created secret which holds the database credentials.      |
| secret_id  | ID of the created secret which holds the database credentials.       |

## Usage

Upon creation of the Secrets Manager secret, AWS will immediately trigger
rotation of the password. This enables the value of the `db_initial_password`
input to be safely stored in the Terraform state file and from the caller of
this module, without needing to encrypt this value, as it will be an invalid
password after Terraform creates all of the resources.

Consequently, though, in order to avoid Terraform from overwriting this secret
with the initial password value, _the secret value will not be updated in subsequent Terragrunt apply calls_,
even if you update any of the `db_*` inputs. To make any changes to the secret
value afterwards, such as changing the DB username, you will have to make these
changes manually via the AWS Console or the CLI.

## Author(s)

Module was created by `Jessie Hernandez`.
