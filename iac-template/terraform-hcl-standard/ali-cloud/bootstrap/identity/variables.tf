variable "region" {
  description = "Alibaba Cloud region"
  type        = string
  default     = "cn-hangzhou"
}

variable "account_id" {
  description = "Alibaba Cloud account ID used for trust policy"
  type        = string
}

variable "role_name" {
  description = "Name of RAM role used by Terraform"
  type        = string
  default     = "TerraformExecutionRole"
}

variable "policy_name" {
  description = "Custom policy name granting Terraform permissions"
  type        = string
  default     = "TerraformAdministrator"
}

variable "user_name" {
  description = "Name of RAM user for Terraform automation"
  type        = string
  default     = "terraform"
}
