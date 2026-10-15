variable "location" {
  type        = string
  description = "The Azure region for this module's resources or telemetry deployment."
  nullable    = false
}

variable "name" {
  type        = string
  description = "The name of the service group member."
}

variable "parent_id" {
  type        = string
  description = "The target ID of the resource to be added as a member to the service group."
}

variable "service_group_name" {
  type        = string
  description = "The name of the service group to which the member will be added."
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

variable "tenant_id" {
  type        = string
  default     = null
  description = <<-DESCRIPTION
  The tenant ID where the service group is located. If not provided, the current tenant ID will be used.
  In order to use cross-tenant resources, you must authenticate using a principal that has access to both tenants.
  The AzAPI provider support this via the `auxiliary_tenant_ids` property.
  The process to enable cross-tenant service principals is outside the scope of this module.
  DESCRIPTION
}
