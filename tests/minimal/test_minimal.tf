terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "netascode/aci"
      version = ">=0.2.0"
    }
  }
}

resource "aci_rest" "fvTenant" {
  dn         = "uni/tn-TF"
  class_name = "fvTenant"
}

resource "aci_rest" "l3extOut" {
  dn         = "uni/tn-${aci_rest.fvTenant.content.name}/out-L3OUT1"
  class_name = "l3extOut"
}

module "main" {
  source = "../.."

  tenant = aci_rest.fvTenant.content.name
  l3out  = aci_rest.l3extOut.content.name
  name   = "EXTEPG1"
}

data "aci_rest" "l3extInstP" {
  dn = module.main.dn

  depends_on = [module.main]
}

resource "test_assertions" "l3extInstP" {
  component = "l3extInstP"

  equal "name" {
    description = "name"
    got         = data.aci_rest.l3extInstP.content.name
    want        = module.main.name
  }
}
