resource "azurerm_key_vault" "akv" {
  name                        = "akv-${var.name}"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = var.enabled_for_disk_encryption
  tenant_id                   = data.azurerm_client_config.current.tenant_id

  soft_delete_retention_days  = var.soft_delete_retention_days 
  purge_protection_enabled    = var.purge_protection_enabled 

  sku_name = var.akv_sku
  public_network_access_enabled = var.public_network_access_enabled
  tags = var.tags

}

# Diagnostic Settings for Key Vault
resource "azurerm_monitor_diagnostic_setting" "keyvault_diag" {
  count = var.enable_diagnostic_settings && var.diagnostic_settings != null ? 1 : 0

  name                = var.diagnostic_settings["to_la"].name
  target_resource_id  = azurerm_key_vault.akv.id
  log_analytics_workspace_id = var.diagnostic_settings["to_la"].workspace_resource_id

  # Logs Configuration
  dynamic "log" {
    for_each = var.enable_diagnostic_settings && var.diagnostic_settings != null ? toset(data.azurerm_monitor_diagnostic_categories.keyvault.logs) : []
    content {
      category = log.value
      enabled  = true
    }
  }

  # Metrics Configuration
  dynamic "metric" {
    for_each = var.enable_diagnostic_settings && var.diagnostic_settings != null ? toset(data.azurerm_monitor_diagnostic_categories.keyvault.metrics) : []
    content {
      category = metric.value
      enabled  = true
    }
  }
}

# Telemetry for Key Vault
resource "azurerm_monitor_diagnostic_setting" "telemetry" {
  count = var.enable_telemetry && var.diagnostic_settings != null ? 1 : 0

  name                = "telemetry-${var.name}"
  target_resource_id  = azurerm_key_vault.akv.id
  log_analytics_workspace_id = var.diagnostic_settings["to_la"].workspace_resource_id

  # Logs Configuration
  dynamic "log" {
    for_each = var.enable_telemetry && var.diagnostic_settings != null ? toset(data.azurerm_monitor_diagnostic_categories.keyvault.logs) : []
    content {
      category = log.value
      enabled  = true
    }
  }

  # Metrics Configuration
  dynamic "metric" {
    for_each = var.enable_telemetry && var.diagnostic_settings != null ? toset(data.azurerm_monitor_diagnostic_categories.keyvault.metrics) : []
    content {
      category = metric.value
      enabled  = true
    }
  }
}
