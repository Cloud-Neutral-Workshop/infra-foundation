variable "table_name" {
  description = "DynamoDB table name for Terraform state lock"
  type        = string
  default     = null
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = null
}

variable "bootstrap" {
  description = "Bootstrap configuration provided by Terragrunt"
  type        = map(any)
  default     = {}
}
