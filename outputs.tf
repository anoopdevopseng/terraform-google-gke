output "name" {
  value = google_container_cluster.primary.name
}

output "location" {
  value = google_container_cluster.primary.location
}

output "endpoint" {
  value = google_container_cluster.primary.endpoint
}

output "master_auth" {
  value = google_container_cluster.primary.master_auth
  sensitive = true
}

output "node_pool" {
 value = google_container_node_pool.primary_nodes
}
