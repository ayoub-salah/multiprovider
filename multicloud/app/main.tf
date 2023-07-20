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
  rg     = var.rg
  vpcs = {
    "vpc1" = {
      name          = "vpc1"
      address_space = ["10.0.0.0/16"]
      location      = "East us"
    }
    # "vpc2" = {
    #   name          = "vpc2"
    #   address_space = ["10.1.0.0/16"]
    #   location      = "East us"
    # }
  }
  # nics = {
  #   nic1 = {
  #     # subnet_id                     = module.subnet.subnet_ids["subnet1"]
  #     subnet_id                     = module.subnet.subnet_ids // string required 
  #     private_ip_address_allocation = "Dynamic"
  #   }
  # nic2 = {
  #   subnet_id                     = module.subnet.subnet_ids
  #   # subnet_id                     = module.subnet.subnet_ids["subnet2"]
  #   private_ip_address_allocation = "Static"
  # }
}

# }
module "subnet" {
  source = "../modules/subnets/azure"
  rg     = var.rg
  subnets = {
    subnet1 = {
      name             = "subnet1"
      address_prefixes = ["10.0.2.10"]
    }
    # subnet2 = {
    #   name             = "subnet2"
    #   address_prefixes = ["10.0.20.10"]
    # }
  }
  vpc_name = module.vpc.vpc_name["vpc1"]
  #  vpc_name = module.vpc.vpc_name["vpc2"]
}



# module "vm" {
#   source = "../modules/vm/azure"
#   vms = {
#     vm1 = {
#       name                            = "myVm01"
#       resource_group_name             = var.rg
#       location                        = "East US"
#       size                            = "Standard_F2"
#       admin_username                  = "adminuser1"
#       disable_password_authentication = false
#       admin_password                  = "Abc_123###"
#       network_interface_ids           = [module.vpc.nic_ids]
#       custom_data                     = "../modules/vm/myScript.sh"
#       os_disk_caching                 = "ReadWrite"
#       os_disk_storage_account_type    = "Standard_LRS"
#       source_image_publisher          = "Canonical"
#       source_image_offer              = "0001-com-ubuntu-server-focal"
#       source_image_sku                = "20_04-lts"
#       source_image_version            = "latest"
#     }
# vm2 = {
#   name                            = "myVm02"
#   resource_group_name             = "myResourceGroup"
#   location                        = "West US"
#   size                            = "Standard_F2s"
#   admin_username                  = "adminuser2"
#   disable_password_authentication = false
#   admin_password                  = "Def_456###"
#   network_interface_ids           = [module.vpc.nic_ids]
#   custom_data                     = "myScript.sh"
#   os_disk_caching                 = "ReadWrite"
#   os_disk_storage_account_type    = "Standard_LRS"
#   source_image_publisher          = "Canonical"
#   source_image_offer              = "0001-com-ubuntu-server-focal"
#   source_image_sku                = "20_04-lts"
#   source_image_version            = "latest"
# } 
# }
# }
