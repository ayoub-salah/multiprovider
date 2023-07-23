output "subnet_ids" {
  value = { for k, subnet in azurerm_subnet.subnet : k => subnet.id }
}