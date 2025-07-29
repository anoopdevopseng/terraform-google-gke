## Setup GKE 
resource "google_container_cluster" "primary" {
  name                     = local.name
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
  for_each = var.enable_private_endpoint == true || length(var.authorized_networks) > 0 || var.gcp_public_cidrs_access_enabled == true ? [true] : []
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

  dynamic "control_plane_endpoints_config" {
    for_each = var.dns_allow_external_traffic != null ? [1] : []
    content {
      dns_endpoint_config {
        allow_external_traffic = var.dns_allow_external_traffic
      }
      ip_endpoints_config {
        enabled = var.allow_ip_traffic
      }
    }
  }
  
  secret_manager_config {
    enabled = true
  }

  deletion_protection = var.deletion_protection
}

resource "null_resource" "argocd_install" {
  count = var.argocd ? 1 : 0
  depends_on = [google_container_cluster.primary]
  provisioner "local-exec" {
    command = <<EOT
      cd ${path.module}
      if ! command -v ansible-playbook &> /dev/null; then
        echo "Ansible not found, attempting installation..."
        if command -v apt-get &> /dev/null; then
          sudo apt-get update && sudo apt-get install -y ansible
        elif command -v yum &> /dev/null; then
          sudo yum install -y ansible
        elif command -v brew &> /dev/null; then
          brew install ansible
        else
          echo "Automatic Ansible installation not supported on this OS."
          exit 1
        fi
      fi
      ansible-playbook ansible/install_tools.yml
      ansible-playbook ansible/install_argocd.yml --extra-vars "project_id=${var.project_id} region=${var.location} cluster_name=${local.name} kubeconfig=kubeconfig_${local.name}.yaml"
    EOT
  }
}