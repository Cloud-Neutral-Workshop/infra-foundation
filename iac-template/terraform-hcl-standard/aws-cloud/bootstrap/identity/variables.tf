variable "region" {
  description = "AWS region"
  type        = string
  default     = null
}

variable "account_name" {
  type        = string
  description = "Which account configuration to load (e.g., dev)"
  default     = null
}

variable "role_name" {
  type        = string
  description = "IAM role name to create (e.g., TerraformDeployRole-Dev)"
  default     = null
}

variable "terraform_user_name" {
  type        = string
  description = "IAM username for Terraform IAC runner"
  default     = null
}
