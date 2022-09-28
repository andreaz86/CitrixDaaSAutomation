resource "google_service_account" "service_account" {
  account_id   = var.gcp_service_account
  display_name = "Test Service account"
}

resource "google_project_iam_member" "project" {
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

resource "google_service_account_key" "mykey" {
  service_account_id = google_service_account.service_account.name
}

