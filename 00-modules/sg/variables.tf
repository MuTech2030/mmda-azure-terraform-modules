variable "azure_network_security_group_name" {
  
}

variable "azure_network_security_group_name_location" {
  
}

variable "tags" {
  
}

variable "resource_group_name" {
  
}

variable "nsg_rules" {
  description = "A list of security rules for the NSG"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}