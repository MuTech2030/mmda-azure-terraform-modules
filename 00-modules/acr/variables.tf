variable "acr_name" {
  type        = string
  description = "Name of the azure container registory"
}
variable "resource_group_name" {
  type        = string
  description = "The resouce group name"
}

variable "location" {
  type        = string
  description = "The location of the Vnet"
}

variable "acr_sku" {
  type        = string
  description = "The ACR SKU"
  default     = "Standard"
}

variable "tags" {
  type = map(string)
}
variable "admin_enabled" {
  description = "Enable or disable the admin user."
  type        = bool
  default     = false
}

variable "zone_redundancy_enabled" {
  description = "Enable or disable zone redundancy for the primary region."
  type        = bool
  default     = false
}


variable "enable_georeplication" {
  description = "Enable or disable georeplication for the ACR."
  type        = bool
  default     = false
}

variable "georeplication_regions" {
  description = "List of georeplication configurations (location, zone redundancy, tags)"
  type = list(object({
    location                = string
    zone_redundancy_enabled = bool
    tags                    = map(string)
  }))
  default = []
}