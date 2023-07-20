# resource "azurerm_linux_virtual_machine" "myVms" {
#   for_each = var.vms

#   name                            = each.value.name
#   resource_group_name             = each.value.resource_group_name
#   location                        = each.value.location
#   size                            = each.value.size
#   admin_username                  = each.value.admin_username
#   disable_password_authentication = each.value.disable_password_authentication
#   admin_password                  = each.value.admin_password

#   network_interface_ids = each.value.network_interface_ids

#   os_disk {
#     caching              = each.value.os_disk_caching
#     storage_account_type = each.value.os_disk_storage_account_type
#   }

#   source_image_reference {
#     publisher = each.value.source_image_publisher
#     offer     = each.value.source_image_offer
#     sku       = each.value.source_image_sku
#     version   = each.value.source_image_version
#   }

#   custom_data = base64encode(each.value.custom_data)
# }

# data "template_file" "linux-vm-cloud-init" {
#   for_each = var.vms

#   template = file(each.value.custom_data)
# }
