# Terraform module for creating VPCs

This module can be used to create a Google kubernetes engine (GKE).

Check out the [`examples`](/examples) directory for usage examples.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 6.27.0, < 7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 6.27.0, < 7 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_container_cluster.primary](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster) | resource |
| [google_container_node_pool.primary_nodes](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool) | resource |
| [google_project_iam_member.cluster_sa_permission](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.cluster_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_ip_traffic"></a> [allow\_ip\_traffic](#input\_allow\_ip\_traffic) | n/a | `bool` | `true` | no |
| <a name="input_authorized_networks"></a> [authorized\_networks](#input\_authorized\_networks) | n/a | <pre>list(object({<br/>    cidr_block = string<br/>    display_name = string<br/>  }))</pre> | `[]` | no |
| <a name="input_cluster_secondary_range_name"></a> [cluster\_secondary\_range\_name](#input\_cluster\_secondary\_range\_name) | n/a | `string` | n/a | yes |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | n/a | `bool` | `true` | no |
| <a name="input_dns_allow_external_traffic"></a> [dns\_allow\_external\_traffic](#input\_dns\_allow\_external\_traffic) | (Optional) Controls whether external traffic is allowed over the dns endpoint. | `bool` | `null` | no |
| <a name="input_enable_private_endpoint"></a> [enable\_private\_endpoint](#input\_enable\_private\_endpoint) | n/a | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name, e.g. dev, stage, or prod | `string` | n/a | yes |
| <a name="input_gcp_public_cidrs_access_enabled"></a> [gcp\_public\_cidrs\_access\_enabled](#input\_gcp\_public\_cidrs\_access\_enabled) | n/a | `bool` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"europe-west3"` | no |
| <a name="input_master_global_access_config"></a> [master\_global\_access\_config](#input\_master\_global\_access\_config) | n/a | `bool` | `false` | no |
| <a name="input_max_pods_per_node"></a> [max\_pods\_per\_node](#input\_max\_pods\_per\_node) | n/a | `string` | `"30"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_node_pools"></a> [node\_pools](#input\_node\_pools) | Map of node pool configurations | <pre>map(object({<br/>    min_node_count = number<br/>    max_node_count = number<br/>    machine_type   = optional(string, "e2-medium")<br/>    preemptible    = optional(bool, false)<br/>    tags           = optional(list(string),[])<br/>  }))</pre> | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | n/a | `string` | n/a | yes |
| <a name="input_release_channel"></a> [release\_channel](#input\_release\_channel) | n/a | `string` | `"REGULAR"` | no |
| <a name="input_services_secondary_range_name"></a> [services\_secondary\_range\_name](#input\_services\_secondary\_range\_name) | n/a | `string` | n/a | yes |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | n/a | `string` | `""` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | n/a | `string` | `"default"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | n/a |
| <a name="output_location"></a> [location](#output\_location) | n/a |
| <a name="output_master_auth"></a> [master\_auth](#output\_master\_auth) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_node_pool"></a> [node\_pool](#output\_node\_pool) | n/a |
<!-- END_TF_DOCS -->