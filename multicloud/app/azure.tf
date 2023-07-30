provider "azurerm" {
  # Configuration options
  subscription_id            = var.subscription_id
  skip_provider_registration = true
  features {}
}
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      # version = "=3.0.0"
    }
  }
}
module "vpc" {
  source = "../modules/vpc/azure"
  # rg     = var.rg
  vpcs = {
    "vpc1" = {
      name              = "vpc1"
      address_space     = ["10.0.0.0/16"]
      availability_zone = var.availability_zone
      resource_group    = var.rg
    },
    "vpc2" = {
      name              = "vpc2"
      address_space     = ["10.1.0.0/16"]
      availability_zone = var.availability_zone
      resource_group    = var.rg

    }

  }

}

module "subnet" {
  source = "../modules/subnet/azure"
  subnets = {
    subnet1 = {
      name           = "subnet1"
      cidr_block     = ["10.0.2.0/24"]
      resource_group = var.rg
      vpc_name       = module.vpc.vpc_name["vpc1"]
    },
    subnet2 = {
      name           = "subnet2"
      cidr_block     = ["10.1.3.0/24"]
      resource_group = var.rg
      vpc_name       = module.vpc.vpc_name["vpc2"]
    },
    subnet5 = {
      name           = "subnet5"
      cidr_block     = ["10.1.4.0/24"]
      resource_group = var.rg
      vpc_name       = module.vpc.vpc_name["vpc2"]
    }
  }
}

module "vms" {
  source = "../modules/vm/azure"

  vms = {
    "vm1" = {
      name                                   = "myVm1"
      resource_group                         = var.rg
      availability_zone                      = "East US"
      size                                   = "Standard_F2"
      admin_username                         = "adminuser"
      disable_password_authentication        = false
      admin_password                         = "Abc_123###"
      public_ip                              = true
      subnet_id                              = module.subnet.subnet_ids["subnet1"]
      private_ip_address_alavailability_zone = "Dynamic"
      myscript                               = file("./myScript.sh")
      rule = {
        priority   = 120,
        open_ports = tolist(["80"])
      }
    },
    "vm2" = {
      name                                   = "myVm2"
      resource_group                         = var.rg
      availability_zone                      = "East US"
      size                                   = "Standard_F2"
      admin_username                         = "adminuser"
      disable_password_authentication        = false
      admin_password                         = "Abc_123###"
      public_ip                              = true
      subnet_id                              = module.subnet.subnet_ids["subnet1"]
      private_ip_address_alavailability_zone = "Dynamic"
      myscript                               = file("./myScript.sh")
      rule = {
        priority   = 130,
        open_ports = tolist([443, 8080])
      }
    },
    "vm3" = {
      name                                   = "myVm3"
      resource_group                         = var.rg
      availability_zone                      = "East US"
      size                                   = "Standard_F2"
      admin_username                         = "adminuser"
      disable_password_authentication        = false
      admin_password                         = "Abc_123###"
      public_ip                              = false
      subnet_id                              = module.subnet.subnet_ids["subnet2"]
      private_ip_address_alavailability_zone = "Dynamic"
      myscript                               = file("./myScript.sh")
      rule = {
        priority   = 140,
        open_ports = tolist([80, 252])
      }

    }
  }
}

resource "azurerm_public_ip" "natPubIP" {
  name                = "nat-gateway-publicIP"
  location            = var.availability_zone
  resource_group_name = var.rg
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
}
resource "azurerm_nat_gateway" "nat" {
  name                    = "nat-Gateway"
  location                = var.availability_zone
  resource_group_name     = var.rg
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
}
resource "azurerm_nat_gateway_public_ip_association" "pubIpAssocNat" {
  nat_gateway_id       = azurerm_nat_gateway.nat.id
  public_ip_address_id = azurerm_public_ip.natPubIP.id
}
resource "azurerm_subnet_nat_gateway_association" "subnetNatAssoc" {
  subnet_id      = module.subnet.subnet_ids["subnet2"]
  nat_gateway_id = azurerm_nat_gateway.nat.id
}
