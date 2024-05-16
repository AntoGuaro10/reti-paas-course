resource "azurerm_user_assigned_identity" "aks_identity" {
  name                = "aks-identity"
  resource_group_name = var.resource_group
  location            = var.location
}

resource "azurerm_role_assignment" "aks_network_contributor" {
  scope                = data.azurerm_virtual_network.paasvnet.id
  principal_id         = azurerm_user_assigned_identity.aks_identity.principal_id
  role_definition_name = "Network Contributor"
}

resource "azurerm_role_assignment" "aks_acr_puller" {
  scope                = azurerm_container_registry.paas-acr.id
  principal_id         = azurerm_user_assigned_identity.aks_identity.principal_id
  role_definition_name = "AcrPull"
  skip_service_principal_aad_check = true
}

resource "azurerm_kubernetes_cluster" "paas-cluster" {
  name                  = "paasaks1"
  location              = var.location
  resource_group_name   = var.resource_group
  dns_prefix            = "paas-cluster"
  
  sku_tier              = "Free"

  default_node_pool {
    name                = "infra"
    node_count          = 1
    vm_size             = "Standard_B2s"
    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = false
    max_pods            = 32
    os_sku              = "Ubuntu"
    os_disk_size_gb     = 32
    vnet_subnet_id      = "/subscriptions/4275b7ef-d10b-4b46-a5ad-e5ff0a1dd9c5/resourceGroups/RGPAASCOURSE/providers/Microsoft.Network/virtualNetworks/PAASVNET/subnets/aks-subnet"
    node_labels         = {
      workload          = "infra"
    }
  }

  identity {
    type                = "UserAssigned"
    identity_ids = [ "${azurerm_user_assigned_identity.aks_identity.id}" ]
  }

  network_profile {
    network_plugin      = "azure"
    network_policy      = "azure"
    service_cidr        = "10.2.0.0/24"
    dns_service_ip      = "10.2.0.10"
  }

  /*api_server_access_profile {
    subnet_id                 = data.azurerm_subnet.default.id
    vnet_integration_enabled  = true
  }*/

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
  os_disk_size_gb       = 30
  node_labels = {
    workload            = "application"
  }
  node_taints         = [ "scope=app:NoSchedule" ]

  tags = {
    owner               = "Guarisco"
    scope               = "paas-course"
  }
}