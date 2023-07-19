resource "aws_vpc" "this" {
  //count  = var.deploy_aws ? 1 : 0
  //for_each = var.deploy_aws ? var.vpcs : {}
  for_each = var.vpcs
  cidr_block = each.value.address_space[0]
  tags = {
    Name = each.key 
  }
}

resource "aws_internet_gateway" "this" {
  //count  = var.deploy_aws ? 1 : 0
  //for_each = var.deploy_aws ? var.vpcs : {}
  
  for_each = var.vpcs
  vpc_id = aws_vpc.this[each.key].id
  tags = {
    Name = "${each.key}-igw"
  }
}