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
### this is azure main root module 
# module "vpc" {
#   source = "../modules/vpc/azure"
#   # rg     = var.rg
#   vpcs = {
#     "vpc1" = {
#       name              = "vpc1"
#       address_space     = ["10.0.0.0/16"]
#       availability_zone = var.availability_zone
#       resource_group    = var.rg
#     },
#     "vpc2" = {
#       name              = "vpc2"
#       address_space     = ["10.1.0.0/16"]
#       availability_zone = var.availability_zone
#       resource_group    = var.rg

#     }

#   }

# }

# module "subnet" {
#   source = "../modules/subnets/azure"
#   # rg     = var.rg
#   subnets = {
#     subnet1 = {
#       name           = "subnet1"
#       cidr_block     = ["10.0.2.0/24"]
#       resource_group = var.rg
#       vpc_name       = module.vpc.vpc_name["vpc1"]
#     },
#     subnet2 = {
#       name           = "subnet2"
#       cidr_block     = ["10.1.3.0/24"]
#       resource_group = var.rg
#       vpc_name       = module.vpc.vpc_name["vpc2"]
#     }

#   }
# }

# module "vms" {
#   source = "../modules/vm/azure"

#   vms = {
#     "vm1" = {
#       resource_group                  = var.rg
#       availability_zone               = "East US"
#       size                            = "Standard_F2"
#       admin_username                  = "adminuser"
#       disable_password_authentication = false
#       admin_password                  = "Abc_123###"
#       public_ip                       = true
#       # subnet_id                      = module.subnet.subnet_ids["subnet1"].id
#       subnet_id                              = module.subnet.subnet_ids["subnet1"]
#       private_ip_address_alavailability_zone = "Dynamic"
#       myscript                               = file("./myScript.sh")
#     },
#     "vm2" = {
#       resource_group                         = var.rg
#       availability_zone                      = "East US"
#       size                                   = "Standard_F2"
#       admin_username                         = "adminuser"
#       disable_password_authentication        = faalse
#       admin_password                         = "Abc_123###"
#       public_ip                              = true
#       subnet_id                              = module.subnet.subnet_ids["subnet1"]
#       private_ip_address_alavailability_zone = "Dynamic"
#       myscript                               = file("./myScript.sh")
#     },
#     "vm3" = {
#       resource_group                         = var.rg
#       availability_zone                      = "East US"
#       size                                   = "Standard_F2"
#       admin_username                         = "adminuser"
#       disable_password_authentication        = false
#       admin_password                         = "Abc_123###"
#       public_ip                              = false
#       subnet_id                              = module.subnet.subnet_ids["subnet2"]
#       private_ip_address_alavailability_zone = "Dynamic"
#       myscript                               = file("./myScript.sh")
#     }
#   }
#   security_rule = [
#     # dynamic {} rule here 
#     {
#       name                       = "mySecRule"
#       priority                   = 100
#       direction                  = "Inbound"
#       access                     = "Allow"
#       protocol                   = "Tcp"
#       source_port_range          = "*"
#       destination_port_range     = "*"
#       source_address_prefix      = "*"
#       destination_address_prefix = "*"
#     }
#   ]
# }

