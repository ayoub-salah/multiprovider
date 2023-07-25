output "vm_ids" {
  value = { for k, vm in azurerm_linux_virtual_machine.vms : k => vm.id }
}
output "public_ip_addresses" {
  value = {
    for k, vm in azurerm_linux_virtual_machine.vms :
    k => var.vms[k].public_ip ? azurerm_network_interface.nic[vm.name].private_ip_address : null
  }
}

output "private_ip_addresses" {
  value = {
    for k, vm in azurerm_linux_virtual_machine.vms :
    k => var.vms[k].public_ip ? azurerm_network_interface.nic[vm.name].private_ip_address : azurerm_network_interface.nic[vm.name].private_ip_address
  }
}

