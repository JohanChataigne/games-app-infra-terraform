resource "azurerm_service_plan" "games_backend" {
  location            = local.location
  name                = "gamesserverbackend"
  resource_group_name = data.azurerm_resource_group.test_terraform.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "games_backend" {
  name                = "gamesserverbackend"
  location            = azurerm_service_plan.games_backend.location
  service_plan_id     = azurerm_service_plan.games_backend.id
  resource_group_name = azurerm_service_plan.games_backend.resource_group_name

  identity {
    type = "SystemAssigned"
  }

  site_config {
    container_registry_use_managed_identity = true
    application_stack {
      docker_registry_url = "https://${azurerm_container_registry.backend_registry.login_server}"
      docker_image_name   = "games-server-backend"
    }

    health_check_path = "/actuator/health"
    always_on = true
  }
}