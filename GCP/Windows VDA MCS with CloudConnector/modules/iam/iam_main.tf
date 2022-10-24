 # Service account creation
resource "google_service_account" "service_account" {
  account_id   = var.gcp_service_account
  display_name = "Service Account used by Citrix"
}

 # configure the service account permissions
resource "google_project_iam_member" "service_account_permission" {
    project = var.gcp_project_id
    for_each = toset([
    "roles/iam.serviceAccountUser",
    "roles/cloudbuild.builds.editor",
    "roles/compute.admin",
    "roles/storage.admin",
  ])
    role = each.key
    member = "serviceAccount:${google_service_account.service_account.email}"
    
}

 # Create the key to be used in Citrix Cloud for hosting connection
resource "google_service_account_key" "mykey" {
  service_account_id = google_service_account.service_account.name
}
