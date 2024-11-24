resource "azurerm_virtual_network" "azure_virtual_network" {
  name                = "vnet${var.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space 
  dns_servers         = var.dns_servers
  tags = var.tags
}

resource "azurerm_subnet" "azure_subnet" {
  for_each            = var.subnets
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.azure_virtual_network.name
  address_prefixes     = each.value.address_prefixes
}

# az ssh vm --resource-group muDigitalTransformation --vm-name vmadaetest
# Install the Monitoring Agent and Configuring the Alerts
# Testing the Alerts with Stress


