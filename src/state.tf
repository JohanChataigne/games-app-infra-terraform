terraform {
  required_version = ">= 1.0.11"

  backend "azurerm" {
    resource_group_name  = "jchataignertestterraform"
    storage_account_name = "jchataignergamestfstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}