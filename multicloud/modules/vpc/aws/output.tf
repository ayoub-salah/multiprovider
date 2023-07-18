output "vpc_ids" {
  description = "The ID of the VPC"
  value = { for k, v in aws_vpc.this : k => v.id }
}

output "internet_gateway_ids" {
  description = "The IDs of the internet gateways"
  value = { for k, igw in aws_internet_gateway.this : k => igw.id }
}