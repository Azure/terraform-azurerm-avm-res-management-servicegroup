variable "name" {
  type        = string
  description = "The name (ID) of the Service Group. This will form part of the resource ID."
  nullable    = false
}

variable "display_name" {
  type        = string
  default     = null
  description = "The name of the service group, if not specified the `name` will be used."
}

variable "enable_telemetry" {
  type        = bool
  default     = true
  description = <<DESCRIPTION
This variable controls whether or not telemetry is enabled for the module.
For more information see <https://aka.ms/avm/telemetryinfo>.
If it is set to false, then no telemetry will be collected.
DESCRIPTION
  nullable    = false
}

variable "parent_service_group_id" {
  type        = string
  default     = null
  description = "The ID (name, not resource ID) of the parent Service Group. If not provided, the tenant level service group will be used as the parent."
}

variable "role_assignments" {
  type = map(object({
    role_definition_id_or_name             = string
    principal_id                           = string
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    delegated_managed_identity_resource_id = optional(string, null)
    principal_type                         = optional(string, null)
  }))
  default     = {}
  description = <<-DESCRIPTION
  A map of role assignments to create on this resource. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

  - `role_definition_id_or_name` - The ID or name of the role definition to assign to the principal.
  - `principal_id` - The ID of the principal to assign the role to.
  - `description` - The description of the role assignment.
  - `skip_service_principal_aad_check` - If set to true, skips the Azure Active Directory check for the service principal in the tenant. Defaults to false.
  - `condition` - The condition which will be used to scope the role assignment.
  - `condition_version` - The version of the condition syntax. Valid values are '2.0'.
  - `delegated_managed_identity_resource_id` - The delegated Azure Resource Id which contains a Managed Identity. Changing this forces a new resource to be created.
  - `principal_type` - The type of the principal_id. Possible values are `User`, `Group` and `ServicePrincipal`. Changing this forces a new resource to be created. It is necessary to explicitly set this attribute when creating role assignments if the principal creating the assignment is constrained by ABAC rules that filters on the PrincipalType attribute.

  > Note: only set `skip_service_principal_aad_check` to true if you are assigning a role to a service principal.
  DESCRIPTION
  nullable    = false
}

variable "service_group_members" {
  type = map(object({
    name             = string
    target_id        = string
    target_tenant_id = optional(string)
  }))
  default     = {}
  description = <<-DESCRIPTION
  A map of service group members to add to the service group. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.
  - `name` - The name of the service group member.
  - `target_id` - The target ID of the resource to be added as a member
  - `target_tenant_id` - The tenant ID where the service group is located. If not provided, the current tenant ID will be used."

  In order to use cross tenant resources, you must authenticate using a principal that has access to both tenants.
  The <https://registry.terraform.io/providers/Azure/azapi/latest/docs#auxiliary_tenant_ids-1> property can be used to add additional tenants to the provider.

  The process to enable cross tenant service principals is outside the scope of this module.
  DESCRIPTION
  nullable    = false
}
