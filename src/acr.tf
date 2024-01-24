resource "azurerm_container_registry" "backend_registry" {
  location            = local.location
  name                = "gamesserverbackend"
  resource_group_name = data.azurerm_resource_group.test_terraform.name
  sku                 = "Basic"
}

resource "azurerm_role_assignment" "app_service_pull" {
  scope        = azurerm_container_registry.backend_registry.id
  principal_id = azurerm_linux_web_app.games_backend.identity[0].principal_id
  role_definition_name = "AcrPull"
}

