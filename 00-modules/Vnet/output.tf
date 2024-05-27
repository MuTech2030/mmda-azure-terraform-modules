output "vnet_id" {
  value = azurerm_virtual_network.azure_virtual_network.id
}


output "subnet_details" {
  value = [for subnet in azurerm_subnet.azure_subnet : {
    name             = subnet.name
    id               = subnet.id
    address_prefixes = subnet.address_prefixes
  }]
}
