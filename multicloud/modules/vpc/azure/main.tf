resource "azurerm_virtual_network" "vNet" {
  name                = "vNet"
  resource_group_name = var.rg
  location            = "East US"
  address_space       = ["10.0.0.0/16"]
}
