terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  subscription_id            = var.subscription_id
  skip_provider_registration = true
  features {}
}
