## Setup GKE 
resource "google_container_cluster" "primary" {
  name                     = var.name
  project                  = var.project_id
  location                 = var.location
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = var.vpc_name
  subnetwork               = var.subnetwork

  private_cluster_config {
    enable_private_endpoint = var.enable_private_endpoint
    enable_private_nodes    = true
    master_global_access_config {
      enabled = var.master_global_access_config
    }
  }

  dynamic "master_authorized_networks_config" {
  for_each = var.enable_private_endpoint == true || length(var.authorized_networks) > 0 ? [true] : []
  content {
    gcp_public_cidrs_access_enabled = var.gcp_public_cidrs_access_enabled

    dynamic "cidr_blocks" {
      for_each = var.authorized_networks
      content {
        cidr_block   = lookup(cidr_blocks.value, "cidr_block", "")
        display_name = lookup(cidr_blocks.value, "display_name", "")
        }
      }
    }
  }

  default_max_pods_per_node = var.max_pods_per_node

  release_channel {
    channel = var.release_channel
  }

  enable_shielded_nodes = true

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.cluster_secondary_range_name
    services_secondary_range_name = var.services_secondary_range_name
  }

  secret_manager_config {
    enabled = true
  }

  deletion_protection = var.deletion_protection
}

