output "name" {
  description = "The name of the Service group."
  value       = azapi_resource.service_group.name
}

output "resource" {
  description = "This is the full output for the Service group."
  value       = azapi_resource.service_group
}

output "resource_id" {
  description = "The resource id of the Service group."
  value       = azapi_resource.service_group.id
}

output "service_group_members" {
  description = "The members of the Service group."
  value       = azapi_resource.service_group_member[*]
}
