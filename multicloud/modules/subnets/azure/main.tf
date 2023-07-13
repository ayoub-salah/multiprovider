module "vpc" {
  source = "../../vpc/azure"
  rg     = var.rg

}
# module "subnet" {
#   source = "./modules/subnet"
#   rg     = var.rg
# }
resource "azurerm_subnet" "mySubnet" {
  name                = "myVmSubnet"
  resource_group_name = var.rg
  # virtual_network_name = azurerm_virtual_network.vNet.name // output 
  virtual_network_name = module.vpc.vnetName
  address_prefixes = ["10.0.1.0/24"]
  
}
