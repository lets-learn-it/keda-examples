resource "azurerm_resource_group" "kedaq-rg" {
  name     = "keda-demo-rg"
  location = "West Europe"
}

resource "azurerm_servicebus_namespace" "keda-namespace" {
  name                = var.servicebus-namespace-name
  location            = azurerm_resource_group.kedaq-rg.location
  resource_group_name = azurerm_resource_group.kedaq-rg.name
  sku                 = "Standard"

}

resource "azurerm_servicebus_queue" "keda-demoq" {
  name         = var.servicebus-queue-name
  namespace_name = azurerm_servicebus_namespace.keda-namespace.name
  resource_group_name = azurerm_resource_group.kedaq-rg.name

  enable_partitioning = true
}

resource "azurerm_servicebus_queue_authorization_rule" "queuerule" {
  name     = "queuerule"
  namespace_name = azurerm_servicebus_namespace.keda-namespace.name
  queue_name = azurerm_servicebus_queue.keda-demoq.name
  resource_group_name = azurerm_resource_group.kedaq-rg.name

  # As per KEDA docs,
  # Service Bus Shared Access Policy needs to be of type Manage.
  # Manage access is required for KEDA to be able to get metrics from Service Bus.
  manage = true
  listen = true
  send = true
}
