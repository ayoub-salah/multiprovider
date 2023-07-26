output vpc_name {
  value       = {
    for k, v in azurerm_virtual_network.vNet : k => v.name
  }
  description = "Vpc outputs"
}


