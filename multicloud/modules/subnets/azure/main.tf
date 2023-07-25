resource "azurerm_subnet" "subnet" {
  for_each               = var.subnets
  name                   = each.key
  address_prefixes       = each.value.cidr_block
  resource_group_name    = each.value.resource_group
  virtual_network_name   = each.value.vpc_name
}
