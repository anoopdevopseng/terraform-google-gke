output "endpoint" {
  value = "https://${google_container_cluster.primary.endpoint}"
}

output "name" {
  value = google_container_cluster.primary.name
}

output "location" {
  value = google_container_cluster.primary.location
}