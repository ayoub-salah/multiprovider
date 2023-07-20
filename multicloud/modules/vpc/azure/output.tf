output vpc_name {
  value       = {
    for k, v in azurerm_virtual_network.vNet : k => v.name
  }
  description = "Vpc outputs"
}


# output "nic_ids" {
#   value = azurerm_network_interface.nic[*].id
# }
# output "test" {
#   value = {for k , v  in azurerm_network_interface.nic : k => v.location}
# }