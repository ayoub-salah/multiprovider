resource "aws_instance" "this" {
  for_each      = var.instances

  subnet_id     = var.subnet_ids[each.value.subnet_name]
  ami           = each.value.ami
  instance_type = each.value.instance_type
  
  //key_name      = each.value.key_name
  //vpc_security_group_ids = each.value.security_groups
  tags = {
    Name = each.key
  }
}
