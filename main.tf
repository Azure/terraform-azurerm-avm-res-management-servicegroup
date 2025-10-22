data "azapi_client_config" "current" {}

resource "azapi_resource" "service_group" {
  name      = var.name
  parent_id = "/"
  type      = "${local.sg_type}@2024-02-01-preview"
  body = {
    properties = {
      displayName = var.display_name
      parent = {
        resourceId = local.sg_id
      }
    }
  }
  create_headers = var.enable_telemetry ? { "User-Agent" : local.avm_azapi_header } : null
  delete_headers = var.enable_telemetry ? { "User-Agent" : local.avm_azapi_header } : null
  read_headers   = var.enable_telemetry ? { "User-Agent" : local.avm_azapi_header } : null
  update_headers = var.enable_telemetry ? { "User-Agent" : local.avm_azapi_header } : null
}

module "service_group_members" {
  source   = "./modules/members"
  for_each = var.service_group_members

  name               = each.value.name
  parent_id          = each.value.target_id
  service_group_name = azapi_resource.service_group.name
  tenant_id          = each.value.target_tenant_id
}

resource "azurerm_role_assignment" "this" {
  for_each = var.role_assignments

  principal_id                           = each.value.principal_id
  scope                                  = "/providers/${local.sg_type}/${azapi_resource.service_group.name}"
  condition                              = each.value.condition
  condition_version                      = each.value.condition_version
  delegated_managed_identity_resource_id = each.value.delegated_managed_identity_resource_id
  principal_type                         = each.value.principal_type
  role_definition_id                     = strcontains(lower(each.value.role_definition_id_or_name), lower(local.role_definition_resource_substring)) ? each.value.role_definition_id_or_name : null
  role_definition_name                   = strcontains(lower(each.value.role_definition_id_or_name), lower(local.role_definition_resource_substring)) ? null : each.value.role_definition_id_or_name
  skip_service_principal_aad_check       = each.value.skip_service_principal_aad_check

  depends_on = [azapi_resource.service_group]
}
