# Module usage examples

- **Naming Convention**  
    Name variable must not contain hyphens (`-`) or underscores (`_`). This is enforced by validation in the Terraform module.

- **Example of invalid values**  
    `my-app`, `my_app`

- **Example of valid values**  
    `myapp`, `myApp`, `Myapp`, `MyApp ` 
    The `name` variable is used to construct a unique cluster name in combination with the `environment` variable.

- **Example of produced values**  
    `myapp-cluster-dev`

## Minimal example

This creates a private Cluster instance with minimal required inputs.
```hcl
module "gke" {
  source              = "git::https://github.com/anoopdevopseng/terraform-google-gke?ref=v0.1.0"
  name                = "myapp"
  project_id          = "my-project-id"
  environment         = "dev"
  location            = "europe-west3-a"
  vpc_name            = "default"
  subnetwork          = "private-subnet"
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

Create multiple nodepools and enable authorized networks

```hcl
module "gke" {
  source              = "git::https://github.com/anoopdevopseng/terraform-google-gke?ref=v0.1.0"
  name                = "gke-test"
  project_id          = "my-project-id"
  environment         = "dev"
  location            = "europe-west3-a"
  vpc_name            = "default"
  subnetwork          = "private-subnet"
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