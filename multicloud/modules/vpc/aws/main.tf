resource "aws_vpc" "this" {
  for_each = var.vpcs
  cidr_block = each.value.cidr_block[0]
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

resource "aws_route_table" "this" {
  for_each = var.vpcs
  vpc_id = aws_vpc.this[each.key].id
  route {
      cidr_block = "0.0.0.0/0"
      //gateway_id = var.internet_gateway_ids[each.key]
      gateway_id = aws_internet_gateway.this[each.key].id
  }
  tags = {
    Name = "public_route_table" 
  }
}