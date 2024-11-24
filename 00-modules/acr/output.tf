output "acr_id" {
  description = "The ID of the Azure Container Registry."
  value       = azurerm_container_registry.acr.id
}

output "acr_name" {
  description = "The name of the Azure Container Registry."
  value       = azurerm_container_registry.acr.name
}

output "georeplication_regions" {
  description = "The georeplication regions of the Azure Container Registry."
  value       = azurerm_container_registry.acr.georeplications[*].location
}
