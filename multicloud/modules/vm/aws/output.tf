output "instance_ids" {
  description = "IDs of the created instances"
  value = { for k, instance in aws_instance.this : k => instance.id }
}