output "subnet_ids" {
  description = "IDs of the created subnets"
  value = { for k, subnet in aws_subnet.this : k => subnet.id }
}