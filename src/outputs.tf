output "web_service_url" {
  value = azurerm_linux_web_app.games_backend.default_hostname
}