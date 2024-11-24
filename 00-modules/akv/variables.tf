variable "name" {
  type        = string
  description = "Name of the Azure Key Vault"
}

variable "resource_group_name" {
  type        = string
  description = "The resouce group name"
}

variable "location" {
  type        = string
  description = "The location of the Azure Key Vault"
}

variable "enabled_for_disk_encryption" {
  type        = bool
  description = "enabled_for_disk_encryption"
  default = true
}

variable "purge_protection_enabled" {
  type        = bool
  description = "purge_protection_enabled"
  default = true
}


variable "akv_sku" {
  type        = string
  description = "The sku of the Azure Key Vault"
  default = "standard"
}

variable "soft_delete_retention_days" {
  description = "The number of days to retain deleted items in the Key Vault."
  type        = number
  default     = 15 # Set a default value (e.g., 90 days)
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled for the Key Vault."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to the Key Vault."
  type        = map(string)
  default     = {}
}
variable "enable_telemetry" {
  description = "Specifies whether telemetry is enabled for the Key Vault."
  type        = bool
  default     = false
}

variable "enable_diagnostic_settings" {
  description = "Specifies whether diagnostic settings are enabled for the Key Vault."
  type        = bool
  default     = false
}

variable "diagnostic_settings" {
  description = "A map of diagnostic settings. Includes log analytics workspace details."
  type = object({
    to_la = optional(object({
      name                  = string
      workspace_resource_id = string
    }))
  })
  default = null
}


variable "log_retention_days" {
  description = "The number of days to retain logs for the Key Vault."
  type        = number
  default     = 30
}

