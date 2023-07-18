resource "aws_vpc" "this" {
  for_each = var.vpcs

  cidr_block = each.value.cidr_block
  tags = {
    Name = each.key 
  }
}

resource "aws_internet_gateway" "this" {
  for_each = var.vpcs

  vpc_id = aws_vpc.this[each.key].id
  tags = {
    Name = "${each.key}-igw"
  }
}