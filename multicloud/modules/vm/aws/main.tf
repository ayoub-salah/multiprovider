resource "aws_instance" "this" {
  for_each      = var.instances

  ami           = each.value.ami
  instance_type = each.value.instance_type
  subnet_id     = each.value.subnet_id
  //key_name      = each.value.key_name
  //vpc_security_group_ids = each.value.security_groups

  tags = {
    Name = each.key
  }
}
