resource "azurerm_virtual_network" "vNet" {

  for_each            = var.vpcs
  name                = each.value.name
  resource_group_name = var.rg
  location            = each.value.location
  # address_space     = ["10.0.0.0/16"]
  address_space       = each.value.address_space
}
# resource "azurerm_network_interface" "nic" {
#   for_each            = var.nics
#   name                = "myNic-${each.key}"
#   location            = var.vpcs[each.key].location
#   resource_group_name = var.rg

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = each.value.subnet_id
#     private_ip_address_allocation = each.value.private_ip_address_allocation
#   }
#   }