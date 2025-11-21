variable "project_id" {
  description = "GCP project id"
  type        = string
}

variable "region" {
  description = "Default region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Default zone"
  type        = string
  default     = "us-central1-a"
}

variable "state_bucket" {
  description = "GCS bucket used for Terraform remote state"
  type        = string
}

variable "state_prefix" {
  description = "Prefix within the state bucket"
  type        = string
  default     = "terraform/state"
}
