resource "aws_subnet" "this" {
  for_each = var.subnets
  vpc_id                  = var.vpc_ids[each.value.vpc_name]
  cidr_block              = each.value.cidr_block[0]
  map_public_ip_on_launch = each.value.map_public_ip
  availability_zone       = each.value.availability_zone
  tags = {
      Name = each.key
    }
}

resource "aws_route_table_association" "public" {
  for_each      = var.subnets
  
  subnet_id     = aws_subnet.this[each.key].id
  route_table_id = var.route_ids[each.value.vpc_name]
}