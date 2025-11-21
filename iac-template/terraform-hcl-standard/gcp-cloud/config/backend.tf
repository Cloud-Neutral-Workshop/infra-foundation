terraform {
  required_version = ">= 1.5.0"

  backend "gcs" {
    bucket  = var.state_bucket
    prefix  = var.state_prefix
    project = var.project_id
  }
}
