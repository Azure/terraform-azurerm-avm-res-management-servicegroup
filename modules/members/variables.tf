variable "name" {
  type        = string
  description = "The name of the service group member."
}

variable "service_group_name" {
  type        = string
  description = "The name of the service group to which the member will be added."
}

variable "target_id" {
  type        = string
  description = "The target ID of the resource to be added as a member to the service group."
}

variable "tenant_id" {
  type        = string
  description = "The tenant ID where the service group is located."
}
