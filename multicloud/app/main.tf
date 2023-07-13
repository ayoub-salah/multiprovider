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

module "vpc" {
  source = "../modules/vpc/azure"
  rg     = var.rg

}
output "bonjour" {
  value = module.vpc.bonjour
}
module "subnet" {
  source = "../modules/subnets/azure"
  rg     = var.rg
}
