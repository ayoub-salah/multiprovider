resource "aws_vpc" "this" {
  for_each = var.vpcs

  cidr_block = each.value.cidr_block
  tags = {
      Name = each.key 
    }
}