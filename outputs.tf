output "dn" {
  value       = aci_rest.l3extInstP.id
  description = "Distinguished name of `l3extInstP` object."
}

output "name" {
  value       = aci_rest.l3extInstP.content.name
  description = "External endpoint group name."
}
