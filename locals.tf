# TODO: insert locals here.
locals {
  role_definition_resource_substring = "/providers/Microsoft.Authorization/roleDefinitions"
  sg_id                              = var.parent_service_group_id != "" ? "/providers/${local.sg_type}/${var.parent_service_group_id}" : "/providers/${local.sg_type}/${var.tenant_id}"
  sg_member_type                     = "Microsoft.Relationships/serviceGroupMember"
  sg_type                            = "Microsoft.Management/serviceGroups"
}
