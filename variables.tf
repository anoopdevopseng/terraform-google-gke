variable "name" {
  type = string
  description = "Base name for the cluster. Must not contain '-' or '_'"

  validation {
    condition     = !can(regex("[-_]", var.name))
    error_message = "The 'name' must not contain hyphens (-) or underscores (_)."
  }
}

variable "project_id" {
  type = string
}

variable "environment" {
  type = string
  description = "The environment name, e.g. dev, stage, or prod"
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

variable "dns_allow_external_traffic" {
  description = "(Optional) Controls whether external traffic is allowed over the dns endpoint."
  type        = bool
  default     = null
}

variable "allow_ip_traffic" {
  type = bool
  default = true
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

variable "argocd" {
  description = "Enable ArgoCD installation"
  type        = bool
  default     = false
}