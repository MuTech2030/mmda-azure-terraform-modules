resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.acr_sku
  admin_enabled       = var.admin_enabled

  zone_redundancy_enabled = var.zone_redundancy_enabled

  # Georeplications for secondary regions
  dynamic "georeplications" {
    for_each = var.enable_georeplication ? var.georeplication_regions : []
    content {
      location                = georeplications.value.location
      zone_redundancy_enabled = georeplications.value.zone_redundancy_enabled
      tags                    = georeplications.value.tags
    }
  }
}
# Encryption: Optional customer-managed key configuration
# Optional private endpoint configuration


