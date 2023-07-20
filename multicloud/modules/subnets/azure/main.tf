resource "azurerm_subnet" "subnet" {
  for_each               = var.subnets
  name                   = each.value.name
  address_prefixes       = each.value.address_prefixes
  resource_group_name    = var.rg
  virtual_network_name   = var.vpc_name
}
# address_prefixes = ["10.0.1.0/24"]