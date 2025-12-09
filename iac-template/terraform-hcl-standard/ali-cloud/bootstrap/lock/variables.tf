variable "region" {
  description = "Alibaba Cloud region for OTS"
  type        = string
  default     = "cn-hangzhou"
}

variable "instance_name" {
  description = "Name of the OTS instance"
  type        = string
  default     = "terraform-locks"
}

variable "table_name" {
  description = "Name of the lock table"
  type        = string
  default     = "terraform-locks"
}
