resource "azurerm_subnet" "subnet" {
  for_each               = var.subnets

  virtual_network_name   = var.vpc_name
  resource_group_name    = var.rg
  address_prefixes       = each.value.cidr_block
  name                   = each.key
}
