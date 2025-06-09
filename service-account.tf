#### Setup ServiceAccount
resource "google_service_account" "cluster_service_account" {
  project      = var.project_id
  account_id   = "${var.name}-sa"
  display_name = "Terraform-managed service account for cluster ${var.name}"
}

resource "google_project_iam_member" "cluster_sa_permission" {
  for_each = toset([
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/artifactregistry.reader",
  ])
  project = var.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.cluster_service_account.email}"
}
