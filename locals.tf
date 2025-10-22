locals {
  role_definition_resource_substring = "/providers/Microsoft.Authorization/roleDefinitions"
  sg_id                              = var.parent_service_group_id != null ? "/providers/${local.sg_type}/${var.parent_service_group_id}" : "/providers/${local.sg_type}/${data.azapi_client_config.current.tenant_id}"
  sg_type                            = "Microsoft.Management/serviceGroups"
}
