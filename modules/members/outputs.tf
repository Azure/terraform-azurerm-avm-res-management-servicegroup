output "resource_id" {
  description = "The resource id of the Service group."
  value       = azapi_resource.service_group_member.output.id
}

output "service_group_member" {
  description = "The members of the Service group."
  value       = azapi_resource.service_group_member.output.properties.targetId
}
