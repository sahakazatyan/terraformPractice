# variable "environment" {
#   description = "The name of the environment (e.g. dev, prod)"
#   type        = string
#   default     = "test"
# }

# Using a separate IAM user with minimum permissions for Terraform
variable "access_key" {
  description = "Access key for the IAM user"
}

variable "secret_key" {
  description = "Secret key for the IAM user"
}
