<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.11 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.11 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_cluster_role.main](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role_binding.main](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_deployment.main](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment) | resource |
| [kubernetes_manifest.state_metrics_sa](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_namespace.main](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_secret.state_metrics_sa](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_limits"></a> [resource\_limits](#input\_resource\_limits) | The deployment resource limits | <pre>object({<br>    cpu    = string<br>    memory = string<br>  })</pre> | <pre>{<br>  "cpu": "60m",<br>  "memory": "50Mi"<br>}</pre> | no |
| <a name="input_resource_requests"></a> [resource\_requests](#input\_resource\_requests) | The deployment resource requests | <pre>object({<br>    cpu    = string<br>    memory = string<br>  })</pre> | <pre>{<br>  "cpu": "30m",<br>  "memory": "30Mi"<br>}</pre> | no |
| <a name="input_version"></a> [version](#input\_version) | Image version of State Metrics | `string` | `"v1.9.8"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->