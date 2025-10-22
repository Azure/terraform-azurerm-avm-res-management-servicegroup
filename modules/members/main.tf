resource "azapi_resource" "service_group_member" {
  name      = var.name
  parent_id = var.parent_id
  type      = "Microsoft.Relationships/serviceGroupMember@2023-09-01-preview"
  body = {
    properties = {
      targetId     = "/providers/Microsoft.Management/serviceGroups/${var.service_group_name}"
      targetTenant = var.tenant_id
    }
  }
  response_export_values    = ["id", "properties.targetId"]
  schema_validation_enabled = false
}
