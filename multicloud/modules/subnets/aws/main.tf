
resource "aws_subnet" "this" {
  for_each = var.subnets

  vpc_id                  = var.vpc_id
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = each.value.map_public_ip
  availability_zone       = each.value.availability_zone

  tags = {
      Name = each.key
    }
}
/*
//routage:
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  dynamic "route" {
    for_each = var.internet_gateway_id != null ? [1] : []
    content {
      cidr_block = "0.0.0.0/0"
      gateway_id = var.internet_gateway_id
    }
  }

  dynamic "route" {
    for_each = var.nat_gateway_id != null ? [1] : []
    content {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = var.nat_gateway_id
    }
  }
  tags = {
    //Name = "my_route_table"
    Name = var.internet_gateway_id != null ? "my_public_route_table" : "my_private_route_table"
  }
}

resource "aws_route_table_association" "public" {
  for_each      = aws_subnet.this
  subnet_id     = each.value.id
  route_table_id = aws_route_table.public.id
}
 */