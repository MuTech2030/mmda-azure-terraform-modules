variable "name" {
  type = string
  description = "Name of the azure resource_group"
}

variable "location" {
  type = string
  description = "Name of the azure region location"
}

variable "tags" {
  type = map(string)
  description = "Name of the azure region location"
}