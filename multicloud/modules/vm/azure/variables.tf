# variable "vms" {
#   type    = map(object({
#     name                            = string
#     resource_group_name             = string
#     location                        = string
#     size                            = string
#     admin_username                  = string
#     disable_password_authentication = bool
#     admin_password                  = string
#     network_interface_ids           = list(string)
#     custom_data                     = string
#     os_disk_caching                 = string
#     os_disk_storage_account_type     = string
#     source_image_publisher          = string
#     source_image_offer              = string
#     source_image_sku                = string
#     source_image_version            = string
#   }))
#   default = {
#     my_vm1 = {
#       name                            = "myVm01"
#       resource_group_name             = "myResourceGroup"
#       location                        = "East US"
#       size                            = "Standard_F2"
#       admin_username                  = "adminuser1"
#       disable_password_authentication = false
#       admin_password                  = "Abc_123###"
#       network_interface_ids           = ["<NIC_ID>"]
#       custom_data                     = "../myScript.sh"
#       os_disk_caching                 = "ReadWrite"
#       os_disk_storage_account_type     = "Standard_LRS"
#       source_image_publisher          = "Canonical"
#       source_image_offer              = "0001-com-ubuntu-server-focal"
#       source_image_sku                = "20_04-lts"
#       source_image_version            = "latest"
#     },
#     my_vm2 = {
#       name                            = "myVm02"
#       resource_group_name             = "myResourceGroup"
#       location                        = "West US"
#       size                            = "Standard_F2s"
#       admin_username                  = "adminuser2"
#       disable_password_authentication = false
#       admin_password                  = "Def_456###"
#       network_interface_ids           = ["<NIC_ID>"]
#       custom_data                     = "myScript.sh"
#       os_disk_caching                 = "ReadWrite"
#       os_disk_storage_account_type     = "Standard_LRS"
#       source_image_publisher          = "Canonical"
#       source_image_offer              = "0001-com-ubuntu-server-focal"
#       source_image_sku                = "20_04-lts"
#       source_image_version            = "latest"
#     }
#   }
# }


















