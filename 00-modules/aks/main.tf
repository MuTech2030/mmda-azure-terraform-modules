resource "azurerm_kubernetes_cluster" "azure_kubernetes_cluster" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  dns_prefix                    = var.dns_prefix_private_cluster
  kubernetes_version            = var.kubernetes_version
  private_cluster_enabled       = true
  tags                          = var.tags

  default_node_pool {
    name                         = var.default_node_pool_name
    vm_size                      = var.default_node_pool_vm_size
    type                         = var.default_node_pool_type
    zones                        = var.zones
    enable_host_encryption       = true
    enable_node_public_ip        = false
    os_disk_size_gb              = var.os_disk_size_gb
    os_sku                       = var.os_sku
    vnet_subnet_id               = var.default_aks_node_pool_vnet_subnet_id
    max_pods                     = var.max_pods
 #   node_taints                  = ["CriticalAddonsOnly=true:NoSchedule"]
    enable_auto_scaling          = true
    min_count                    = 1
    max_count                    = 1
    node_count                   = 1
  }

  network_profile {
    network_plugin               = var.network_plugin
    service_cidr      = "172.21.0.0/16"
    dns_service_ip    = "172.21.0.10"
  }

  identity {
    type                         = "SystemAssigned"
  }

  azure_active_directory_role_based_access_control {
    managed                      = true
    azure_rbac_enabled           = true
  }

  auto_scaler_profile {
    max_graceful_termination_sec = 600
    max_node_provisioning_time   = "15m"
    scan_interval                = "30s"
    scale_down_delay_after_add   = "10m"
    scale_down_unneeded          = "10m"
    scale_down_unready           = "20m"
    scale_down_utilization_threshold = "0.5"
  }

  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count,
    ]
  #  prevent_destroy = true
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "azure_kubernetes_cluster_node_pool" {
  for_each                  = var.azure_kubernetes_cluster_node_pools
  kubernetes_cluster_id     = azurerm_kubernetes_cluster.azure_kubernetes_cluster.id
  name                      = each.key
  vm_size                   = each.value.vm_size
  zones                     = each.value.zones
  enable_host_encryption    = true
  enable_node_public_ip     = false
  os_disk_size_gb           = each.value.os_disk_size_gb
  os_sku                    = each.value.os_sku
  vnet_subnet_id            = each.value.azure_aks_node_pool_vnet_subnet_id 
  max_pods                  = each.value.max_pods
  mode                      = each.value.mode
  enable_auto_scaling       = each.value.enable_auto_scaling
  min_count                 = each.value.min_count
  max_count                 = each.value.max_count
  node_count                = each.value.node_count

  tags                      = var.tags
  upgrade_settings {
    max_surge               = tostring(each.value.max_surge)
  }

  lifecycle {
    ignore_changes = [
      node_count,
    ]
   # prevent_destroy = true
  }
}

resource "azurerm_container_registry" "acr" {
  name                      = var.acr_name
  resource_group_name       = var.resource_group_name
  location                  = var.location
  sku                       = var.sku
  admin_enabled             = false

}

