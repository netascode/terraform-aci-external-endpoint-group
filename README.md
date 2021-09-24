<!-- BEGIN_TF_DOCS -->
[![Tests](https://github.com/netascode/terraform-aci-external-endpoint-group/actions/workflows/test.yml/badge.svg)](https://github.com/netascode/terraform-aci-external-endpoint-group/actions/workflows/test.yml)

# Terraform ACI External Endpoint Group Module

Manages ACI External Endpoint Group

Location in GUI:
`Tenants` » `XXX` » `Networking` » `L3outs` » `XXX` » `External EPGs`

## Examples

```hcl
module "aci_external_endpoint_group" {
  source  = "netascode/external-endpoint-group/aci"
  version = ">= 0.0.1"

  tenant          = "ABC"
  l3out           = "L3OUT1"
  name            = "EXTEPG1"
  alias           = "EXTEPG1-ALIAS"
  description     = "My Description"
  preferred_group = true
  subnets = [{
    name                    = "SUBNET1"
    prefix                  = "10.0.0.0/8"
    import_route_control    = true
    export_route_control    = true
    shared_route_control    = true
    import_security         = true
    shared_security         = true
    bgp_route_summarization = true
  }]
  contract_consumers          = ["CON1"]
  contract_providers          = ["CON1"]
  contract_imported_consumers = ["ICON1"]
}

```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aci"></a> [aci](#requirement\_aci) | >= 0.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aci"></a> [aci](#provider\_aci) | >= 0.2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tenant"></a> [tenant](#input\_tenant) | Tenant name. | `string` | n/a | yes |
| <a name="input_l3out"></a> [l3out](#input\_l3out) | L3out name. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name. | `string` | n/a | yes |
| <a name="input_alias"></a> [alias](#input\_alias) | Alias. | `string` | `""` | no |
| <a name="input_description"></a> [description](#input\_description) | Description. | `string` | `""` | no |
| <a name="input_preferred_group"></a> [preferred\_group](#input\_preferred\_group) | Preferred group membership. | `bool` | `false` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | List of subnets. Default value `import_route_control`: false. Default value `export_route_control`: false. Default value `shared_route_control`: false. Default value `import_security`: true. Default value `shared_security`: false. Default value `bgp_route_summarization`: false. | <pre>list(object({<br>    name                    = optional(string)<br>    prefix                  = string<br>    import_route_control    = optional(bool)<br>    export_route_control    = optional(bool)<br>    shared_route_control    = optional(bool)<br>    import_security         = optional(bool)<br>    shared_security         = optional(bool)<br>    bgp_route_summarization = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_contract_consumers"></a> [contract\_consumers](#input\_contract\_consumers) | List of contract consumers. | `list(string)` | `[]` | no |
| <a name="input_contract_providers"></a> [contract\_providers](#input\_contract\_providers) | List of contract providers. | `list(string)` | `[]` | no |
| <a name="input_contract_imported_consumers"></a> [contract\_imported\_consumers](#input\_contract\_imported\_consumers) | List of imported contract consumers. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dn"></a> [dn](#output\_dn) | Distinguished name of `l3extInstP` object. |
| <a name="output_name"></a> [name](#output\_name) | External endpoint group name. |

## Resources

| Name | Type |
|------|------|
| [aci_rest.fvRsCons](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.fvRsConsIf](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.fvRsProv](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.l3extInstP](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.l3extRsSubnetToRtSumm](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.l3extSubnet](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
<!-- END_TF_DOCS -->