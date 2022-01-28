locals {
  contracts_dn = {
    consumers          = [for con in var.contract_consumers == null ? [] : var.contract_consumers : "uni/tn-${var.tenant}/brc-${con}"]
    providers          = [for con in var.contract_providers == null ? [] : var.contract_providers : "uni/tn-${var.tenant}/brc-${con}"]
    imported_consumers = [for con in var.contract_imported_consumers == null ? [] : var.contract_imported_consumers : "uni/tn-${var.tenant}/cif-${con}"]
  }
}

resource "aci_rest_managed" "l3extInstP" {
  dn         = "uni/tn-${var.tenant}/out-${var.l3out}/instP-${var.name}"
  class_name = "l3extInstP"
  content = {
    name       = var.name
    nameAlias  = var.alias
    descr      = var.description
    prefGrMemb = var.preferred_group == true ? "include" : "exclude"
  }
}

resource "aci_rest_managed" "fvRsCons" {
  for_each   = toset(var.contract_consumers)
  dn         = "${aci_rest_managed.l3extInstP.dn}/rscons-${each.value}"
  class_name = "fvRsCons"
  content = {
    tnVzBrCPName = each.value
  }
}

resource "aci_rest_managed" "fvRsProv" {
  for_each   = toset(var.contract_providers)
  dn         = "${aci_rest_managed.l3extInstP.dn}/rsprov-${each.value}"
  class_name = "fvRsProv"
  content = {
    tnVzBrCPName = each.value
  }
}

resource "aci_rest_managed" "fvRsConsIf" {
  for_each   = toset(var.contract_imported_consumers)
  dn         = "${aci_rest_managed.l3extInstP.dn}/rsconsIf-${each.value}"
  class_name = "fvRsConsIf"
  content = {
    tnVzCPIfName = each.value
  }
}

resource "aci_rest_managed" "l3extSubnet" {
  for_each   = { for subnet in var.subnets : subnet.prefix => subnet }
  dn         = "${aci_rest_managed.l3extInstP.dn}/extsubnet-[${each.value.prefix}]"
  class_name = "l3extSubnet"
  content = {
    ip    = each.value.prefix
    name  = each.value.name != null ? each.value.name : ""
    scope = join(",", concat(each.value.export_route_control == true ? ["export-rtctrl"] : [], each.value.import_route_control == true ? ["import-rtctrl"] : [], each.value.import_security == false ? [] : ["import-security"], each.value.shared_route_control == true ? ["shared-rtctrl"] : [], each.value.shared_security == true ? ["shared-security"] : []))
  }
}

resource "aci_rest_managed" "l3extRsSubnetToRtSumm" {
  for_each   = { for subnet in var.subnets : subnet.prefix => subnet if subnet.bgp_route_summarization == true }
  dn         = "${aci_rest_managed.l3extSubnet[each.value.prefix].dn}/rsSubnetToRtSumm"
  class_name = "l3extRsSubnetToRtSumm"
  content = {
    tDn = "uni/tn-common/bgprtsum-default"
  }
}
