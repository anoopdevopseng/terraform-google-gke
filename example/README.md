# Module usage examples

## Minimal example

This creates a private Cluster instance with minimal required inputs.
```hcl
module "gke" {
  source              = "github.com/anoopdevopseng/terraform-google-gke"
  name                = "gke-test"
  project_id          = "google-project-id"
  location            = "europe-west3"
  vpc_name            = "default"
  subnetwork          = "private"
  cluster_secondary_range_name = "gke-pod-range"
  services_secondary_range_name = "gke-service-range"
  deletion_protection = false
  node_pools = {
    pool-linux = {
      min_node_count       = 1
      max_node_count       = 2
      machine_type         = "e2-medium"
    }
  }
}

output "endpoint" {
  value = module.gke.endpoint
}
```

## Create multiple nodepools and enable authorized networks

```hcl
module "gke" {
  source              = "github.com/anoopdevopseng/terraform-google-gke"
  name                = "gke-test"
  project_id          = "google-project-id"
  location            = "europe-west3"
  vpc_name            = "default"
  subnetwork          = "private"
  cluster_secondary_range_name = "gke-pod-range"
  services_secondary_range_name = "gke-service-range"
  deletion_protection = false
  gcp_public_cidrs_access_enabled = true
  node_pools = {
    pool-linux = {
      min_node_count       = 1
      max_node_count       = 2
      machine_type         = "e2-medium"
      preemptible          = false
    },
    pool-window = {
      min_node_count       = 1
      max_node_count       = 2
      machine_type         = "e2-medium"
      preemptible          = false
    }
  }
  authorized_networks = [
    {
      cidr_block    = "10.0.0.0/16"
      display_name  = "bastion-host-vm"
    }
  ]
}

output "endpoint" {
  value = module.gke.endpoint
}
```