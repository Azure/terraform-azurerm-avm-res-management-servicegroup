resource "azapi_resource" "service_group_member" {
  name      = var.name
  parent_id = var.parent_id
  type      = "${local.sg_member_type}@2023-09-01-preview"
  body = {
    properties = {
      targetId     = "/providers/${local.sg_type}/${var.service_group_name}"
      targetTenant = var.tenant_id
    }
  }
  schema_validation_enabled = false
}
