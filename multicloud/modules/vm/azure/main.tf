resource "azurerm_linux_virtual_machine" "vms" {
  for_each                        = var.vms
  name                            = each.key
  resource_group_name             = each.value.resource_group
  location                        = each.value.location
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

  # Custom data for VM initialization (if needed)
  # custom_data = each.value.custom_data
}

resource "azurerm_network_interface" "nic" {
  for_each            = var.vms
  name                = "nic-${each.key}"
  location            = each.value.location
  resource_group_name = each.value.resource_group

  ip_configuration {
    name                          = "ipconfig-${each.key}"
    subnet_id                     = each.value.subnet_id
    private_ip_address_allocation = each.value.private_ip_address_allocation
    public_ip_address_id          = each.value.public_ip ? azurerm_public_ip.pub_vm[each.key].id : null
  }
}

resource "azurerm_public_ip" "pub_vm" {
  for_each            = var.vms

  name                = "publicip-${each.key}"
  location            = each.value.location
  resource_group_name = each.value.resource_group
  allocation_method   = "Dynamic"
}