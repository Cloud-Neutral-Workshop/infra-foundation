terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
}

variable "project_id" {
  description = "GCP project id where Firestore will be enabled"
  type        = string
}

variable "location" {
  description = "Firestore location"
  type        = string
  default     = "us-central"
}

resource "google_project_service" "firestore" {
  service = "firestore.googleapis.com"
  project = var.project_id
}

resource "google_project_service" "cloudresourcemanager" {
  service = "cloudresourcemanager.googleapis.com"
  project = var.project_id
}

resource "google_firestore_database" "default" {
  name        = "(default)"
  location_id = var.location
  project     = var.project_id
  type        = "DATASTORE_MODE"
  depends_on  = [google_project_service.firestore, google_project_service.cloudresourcemanager]
}

output "firestore_database" {
  description = "Firestore database ID"
  value       = google_firestore_database.default.name
}
