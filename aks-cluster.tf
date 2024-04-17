resource "azurerm_kubernetes_cluster" "paas-cluster" {
  name                  = "paasaks1"
  location              = var.location
  resource_group_name   = var.resource_group
  dns_prefix            = "paas"
  
  sku_tier              = "Free"

  default_node_pool {
    name                = "infra"
    node_count          = 1
    vm_size             = "Standard_B2s"
    enable_auto_scaling = false
    max_pods            = 32
    os_sku              = "Ubuntu"
    os_disk_size_gb     = 30
    vnet_subnet_id      = "/subscriptions/4275b7ef-d10b-4b46-a5ad-e5ff0a1dd9c5/resourceGroups/RGPAASCOURSE/providers/Microsoft.Network/virtualNetworks/PAASVNET/subnets/aks-subnet"
    node_labels         = {
      workload          = "infra"
    }
  }

  identity {
    type                = "SystemAssigned"
  }

  network_profile {
    network_plugin      = "azure"
    service_cidr        = "10.0.2.0/27"
    dns_service_ip      = "10.0.2.2"
  }

  api_server_access_profile {
    subnet_id           = data.azurerm_subnet.default.id
    vnet_integration_enabled = true
  }

  storage_profile {
    disk_driver_enabled = true
    file_driver_enabled = true
  }

  tags = {
    owner               = "Guarisco"
    scope               = "paas-course"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "application-np" {
  name                  = "application"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.paas-cluster.id
  mode                  = "User"
  vm_size               = "Standard_B2s"
  node_count            = 2
  max_pods              = 16
  os_disk_size_gb       = 16
  node_labels = {
    workload            = "application"
  }
  # node_taints         = [ "key=app:NoSchedule" ]

  tags = {
    owner               = "Guarisco"
    scope               = "paas-course"
  }
}