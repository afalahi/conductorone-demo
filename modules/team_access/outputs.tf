output "group_id" {
  description = "The ID of the group created in ConductorOne"
  value       = conductorone_app_resource.group.id

}

output "ent_id" {
  description = "The ID of the entitlement created in ConductorOne"
  value       = conductorone_custom_app_entitlement.member.id
}
