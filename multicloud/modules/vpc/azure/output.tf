output vpc_name {
  value       = {
    for k, v in azurerm_virtual_network.vNet : k => v.name
  }
  description = "Vpc outputs"
}
/*
output "vpc_names" {
  description = "The names of the VPCs"
  value = { for k, v in aws_vpc.this : k => v.tags.Name }
}
*/