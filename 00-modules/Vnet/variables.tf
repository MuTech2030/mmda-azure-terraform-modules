variable "vnet_name" {
  type = string
  description = "The Name of the Vnet"
}
variable "location" {
  type = string
  description = "The location of the Vnet"
}

variable "tags" {
  type = map(string)
}

variable "resource_group_name" {
  type = string
  description = "The resouce group name"
}

variable "address_space" {
type        = list(string)
  description = "The address space that is used by the virtual network."
 
}

variable "dns_servers" {
  type        = list(string)
  description = "List of IP addresses of DNS servers used by the virtual network."

}

variable "subnets" {
  type = map(object({
    address_prefixes = list(string)
  }))
  description = "A map of subnets to create"
}
