variable "bucket_name" {
  description = "S3 bucket name for Terraform state"
  type        = string
  default     = null
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = null
}
