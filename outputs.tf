output "service_group_members" {
  description = "The members of the Service group."
  value       = { for k, v in module.service_group_members : k => v.service_group_member }
}

output "service_group_name" {
  description = "The name of the Service group."
  value       = azapi_resource.service_group.name
}

output "service_group_resource_id" {
  description = "The resource id of the Service group."
  value       = azapi_resource.service_group.id
}
