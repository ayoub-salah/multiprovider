output "vm_ids" {
  value = { for k, vm in azurerm_linux_virtual_machine.vms : k => vm.id }
}

output "public_ip_addresses" {
  value = {
    for k, vm in azurerm_linux_virtual_machine.vms :
    # k => vm.network_interface_ids[0] != null ? azurerm_network_interface.nic[k].private_ip_address : null
    k => vm.network_interface_ids[0] != null ? azurerm_public_ip.pub_vm[k].ip_address : null
  }
}

output "private_ip_addresses" {
  value = {
    for k, vm in azurerm_linux_virtual_machine.vms :
    k => vm.network_interface_ids[0] != null ? azurerm_network_interface.nic[k].private_ip_address : null
  }
}
