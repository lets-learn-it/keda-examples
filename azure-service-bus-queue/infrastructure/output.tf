output "namespace_primary_connection_string" {
    value = azurerm_servicebus_namespace.keda-namespace.default_primary_connection_string
}

output "queue_primary_connection_string" {
    value = azurerm_servicebus_queue_authorization_rule.queuerule.primary_connection_string
}
