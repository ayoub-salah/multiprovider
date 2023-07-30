provider "google" {
  credentials = file("creds.json")
  project     = jsondecode(file("creds.json")).project_id
  region      = "europe-west1"
}
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA2FTTSXCQAHLVADNP"
  secret_key = "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"
}
provider "azurerm" {
  # Configuration options
  subscription_id            = var.subscription_id
  skip_provider_registration = true
  features {}
}
