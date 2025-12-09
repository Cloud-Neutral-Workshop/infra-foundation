variable "region" {
  description = "Default Alibaba Cloud region"
  type        = string
  default     = "cn-hangzhou"
}

variable "access_key" {
  description = "Alibaba Cloud Access Key ID"
  type        = string
  default     = null
}

variable "secret_key" {
  description = "Alibaba Cloud Access Key Secret"
  type        = string
  default     = null
  sensitive   = true
}

variable "security_token" {
  description = "Optional security token when using STS credentials"
  type        = string
  default     = null
  sensitive   = true
}

variable "ram_role_arn" {
  description = "Optional RAM role ARN to assume for operations"
  type        = string
  default     = null
}

variable "session_name" {
  description = "Session name when assuming a RAM role"
  type        = string
  default     = "terraform"
}

variable "state_bucket" {
  description = "OSS bucket used for Terraform remote state"
  type        = string
}

variable "state_prefix" {
  description = "Prefix within the remote state bucket"
  type        = string
  default     = "terraform/state"
}

variable "lock_table" {
  description = "OTS table used for state locking"
  type        = string
  default     = "terraform-locks"
}
