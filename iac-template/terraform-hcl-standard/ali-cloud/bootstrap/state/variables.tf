variable "region" {
  description = "Alibaba Cloud region for OSS"
  type        = string
  default     = "cn-hangzhou"
}

variable "state_bucket" {
  description = "Name of the OSS bucket used for remote state"
  type        = string
}

variable "acl" {
  description = "ACL for the OSS bucket"
  type        = string
  default     = "private"
}
