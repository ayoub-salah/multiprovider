output "instance_ids" {
  description = "IDs of the created instances"
  value = { for k, instance in aws_instance.this : k => instance.id }
}
output "security_group_ids" {
  description = "The IDs of the security groups"
  value       = { for name, sg in aws_security_group.security_group : name => sg.id }
}
