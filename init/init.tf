terraform {
  required_version = ">= 1.0.11"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.88.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "terraform" {
  name = "jchataignertestterraform"
  location = "West Europe"
}

resource "azurerm_storage_account" "state" {
  name = "jchataignergamestfstate"
  resource_group_name = azurerm_resource_group.terraform.name
  location = azurerm_resource_group.terraform.location

  account_kind = "BlobStorage"
  account_tier = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "state" {
  name                 = "tfstate"
  storage_account_name = azurerm_storage_account.state.name
}

