output "virtual_network_id" {
  value = azurerm_virtual_network.azure_virtual_network.id
  description = "The ID of the Virtual Network."
}

output "subnet_details" {
  value = [for subnet in azurerm_subnet.azure_subnet : {
    name             = subnet.name
    id               = subnet.id
    address_prefixes = subnet.address_prefixes
  }]
  description = "Details of the Subnets created, including names, IDs, and address prefixes."
}
