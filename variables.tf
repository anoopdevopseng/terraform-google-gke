variable "name" {
  type = string
}

variable "project_id" {
  type = string
}

variable "location" {
  type    = string
  default = "europe-west3"
}

variable "max_pods_per_node" {
  type    = string
  default = "30"
}

variable "release_channel" {
  type    = string
  default = "REGULAR"
}

variable "vpc_name" {
  type    = string
  default = "default"
}

variable "subnetwork" {
  type    = string
  default = ""
}

variable "enable_private_endpoint" {
  type    = bool
  default = true
}

variable "master_global_access_config" {
  type = bool
  default = false
}

variable "gcp_public_cidrs_access_enabled" {
  type = bool
  default = null
}

variable "cluster_secondary_range_name" {
  type = string
}

variable "services_secondary_range_name" {
  type = string
}

variable "deletion_protection" {
  type    = bool
  default = true
}

variable "node_pools" {
  description = "Map of node pool configurations"
  type = map(object({
    min_node_count = number
    max_node_count = number
    machine_type   = optional(string, "e2-medium")
    preemptible    = optional(bool, false)
    tags           = optional(list(string),[])
  }))
}

variable "authorized_networks" {
  type = list(object({
    cidr_block = string
    display_name = string
  }))
  default = []
}