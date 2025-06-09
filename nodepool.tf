resource "google_container_node_pool" "primary_nodes" {
  for_each = var.node_pools

  name     = "${var.name}-${each.key}"
  cluster  = google_container_cluster.primary.name
  location = var.location
  project  = var.project_id

  node_config {
    preemptible  = each.value.preemptible
    machine_type = each.value.machine_type

    service_account = google_service_account.cluster_service_account.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    tags = concat(["${var.name}-${each.key}"],each.value.tags )
  }

  autoscaling {
    min_node_count = each.value.min_node_count
    max_node_count = each.value.max_node_count

  }

  network_config {
    enable_private_nodes = true
  }

}