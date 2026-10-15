variable "enable_telemetry" {
  type     = bool
  default  = true
  nullable = false
}

variable "location" {
  type        = string
  default     = "eastus"
  description = "The Azure region for this module's resources or telemetry deployment."
  nullable    = false
}
