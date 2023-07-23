resource "azurerm_virtual_network" "vNet" {
  for_each            = var.vpcs
  name                = each.key
  resource_group_name = each.value.resource_group
  location            = each.value.location
  address_space       = each.value.address_space
}
