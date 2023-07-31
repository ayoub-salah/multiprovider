provider "google" {
  credentials = file("creds.json")
  project     = jsondecode(file("creds.json")).project_id
  region      = "europe-west1"
}
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAXHICZURJCZUJB67O"
  secret_key = "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"
}
provider "azurerm" {
  # Configuration options
  subscription_id            = var.subscription_id
  skip_provider_registration = true
  features {}
}
