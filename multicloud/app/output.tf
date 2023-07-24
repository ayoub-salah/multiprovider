output "vpc_names" {
  value = module.vpc.vpc_name
}

output "subnet_ids" {
  value = module.subnet.subnet_ids
}

output "public_ip_addresses" {
  value = module.vms.public_ip_addresses
}

output "private_ip_addresses" {
  value = module.vms.private_ip_addresses
}
