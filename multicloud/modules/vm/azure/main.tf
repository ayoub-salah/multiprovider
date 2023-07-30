resource "azurerm_linux_virtual_machine" "vms" {
  for_each                        = var.vms
  name                            = each.value.name
  resource_group_name             = each.value.resource_group
  location                        = each.value.availability_zone
  size                            = each.value.size
  admin_username                  = each.value.admin_username
  disable_password_authentication = each.value.disable_password_authentication
  admin_password                  = each.value.admin_password

  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
  // we use try in option attribute

  # Custom data for VM initialization
  custom_data = base64encode(each.value.myscript)
}
resource "azurerm_network_interface" "nic" {
  for_each            = var.vms
  name                = "nic-${each.key}"
  location            = each.value.availability_zone
  resource_group_name = each.value.resource_group

  ip_configuration {
    name                          = "ipconfig-${each.key}"
    subnet_id                     = each.value.subnet_id
    private_ip_address_allocation = each.value.private_ip_address_alavailability_zone
    public_ip_address_id          = each.value.public_ip ? azurerm_public_ip.pub_vm[each.key].id : null
  }
}

resource "azurerm_public_ip" "pub_vm" {
  for_each            = var.vms
  name                = "publicip-${each.key}"
  location            = each.value.availability_zone
  resource_group_name = each.value.resource_group
  allocation_method   = "Dynamic"
}
resource "azurerm_network_security_group" "nsg" {
  for_each            = var.vms
  name                = "myNsg"
  location            = each.value.availability_zone
  resource_group_name = each.value.resource_group



  security_rule {
    name                       = "${each.value.name}-security_rule"
    priority                   = each.value.rule.priority
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = each.value.rule.open_ports
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


}
resource "azurerm_network_interface_security_group_association" "nsgAssocNic" {
  for_each                  = var.vms
  network_interface_id      = azurerm_network_interface.nic[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}
