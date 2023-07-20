provider "aws" {
  region     = "us-east-1"
  access_key = "AKIATYAYX2YDODNRSA7C"
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
  subscription_id            = "80ea84e8-afce-4851-928a-9e2219724c69"
  skip_provider_registration = true
  features {}
}