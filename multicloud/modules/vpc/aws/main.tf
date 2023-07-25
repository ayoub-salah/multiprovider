resource "aws_vpc" "this" {
  for_each = var.vpcs_aws
  cidr_block = each.value.address_space[0]
  tags = {
    Name = each.key
  }
}

resource "aws_internet_gateway" "this" {
  for_each = var.vpcs_aws
  vpc_id = aws_vpc.this[each.key].id
  tags = {
    Name = "${each.key}-igw"
  }
}