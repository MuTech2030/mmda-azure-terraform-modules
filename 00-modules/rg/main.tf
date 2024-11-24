resource "azurerm_resource_group" "azure_resource_group" {
  name     = "rg-${var.name}"
  location = var.location
  tags = var.tags
}
