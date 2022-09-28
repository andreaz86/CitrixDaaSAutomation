terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    tls = {
      source = "hashicorp/tls"
    }
  }
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  #  zone    = var.zone
}

provider "tls" {
  // no config needed
}