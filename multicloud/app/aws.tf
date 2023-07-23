provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAVRWMATKQDODNFCWT"
  secret_key = "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"
}

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
  subscription_id            = "0cfe2870-d256-4119-b0a3-16293ac11bdc"
  skip_provider_registration = true
  features {}
}