# Outputs for the Key Vault Module

output "key_vault_id" {
  description = "The ID of the Azure Key Vault."
  value       = azurerm_key_vault.akv.id
}

output "key_vault_name" {
  description = "The name of the Azure Key Vault."
  value       = azurerm_key_vault.akv.name
}

output "key_vault_uri" {
  description = "The URI of the Azure Key Vault."
  value       = azurerm_key_vault.akv.vault_uri
}

output "key_vault_telemetry_enabled" {
  description = "Indicates if telemetry is enabled for the Key Vault."
  value       = var.enable_telemetry
}

output "key_vault_diagnostic_settings" {
  description = "The diagnostic settings configuration applied to the Key Vault."
  value       = azurerm_monitor_diagnostic_setting.keyvault_diag[*]
}
