output "vpc_ids" {
  description = "The ID of the VPC"
  value = { for k, v in aws_vpc.this : k => v.id }
  //value       = aws_vpc.this.id
}