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

module "vpc" {
  source = "../modules/vpc/azure"
  # rg     = var.rg
  vpcs = {
    "vpc1" = {
      name          = "vpc1"
      address_space = ["10.0.0.0/16"]
      location      = var.location
      resource_group = var.rg
    }
    
  }

}

module "subnet" {
  source = "../modules/subnets/azure"
  # rg     = var.rg
  subnets = {
    subnet1 = {
      name             = "subnet1"
      address_prefixes = ["10.0.2.0/24"]
      resource_group   = var.rg

    }
   
  }
  vpc_name = module.vpc.vpc_name["vpc1"]
  #  vpc_name = module.vpc.vpc_name["vpc2"]
}


module "vms" {
  source = "../modules/vm/azure"

  vms = {
    "vm1" = {
      resource_group                 = var.rg
      location                       = "East US"
      size                           = "Standard_F2"
      admin_username                 = "adminuser"
      disable_password_authentication = false
      admin_password                 = "Abc_123###"
      public_ip                      = true
      # subnet_id                      = module.subnet.subnet_ids["subnet1"].id
      subnet_id                      = module.subnet.subnet_ids["subnet1"]
      private_ip_address_allocation  = "Dynamic"
    },
    "vm2" = {
      resource_group                 = var.rg
      location                       = "East US"
      size                           = "Standard_F2"
      admin_username                 = "adminuser"
      disable_password_authentication = false
      admin_password                 = "Abc_123###"
      public_ip                      = true
      subnet_id                      = module.subnet.subnet_ids["subnet1"]
      private_ip_address_allocation  = "Dynamic"
    },
    "vm3" = {
      resource_group                 = var.rg
      location                       = "East US"
      size                           = "Standard_F2"
      admin_username                 = "adminuser"
      disable_password_authentication = false
      admin_password                 = "Abc_123###"
      public_ip                      = false
      subnet_id                      = module.subnet.subnet_ids["subnet1"]
      private_ip_address_allocation  = "Dynamic"
    },
  }
}


  



