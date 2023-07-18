/*
variable "vpcs" {
  description = "Une carte des VPC à créer"
  type        = map(object({ cidr_block = string }))
  default = {
    vpc_1 = { cidr_block = "192.168.1.0/24"},
    vpc_2 = { cidr_block = "192.168.2.0/24"},
    vpc_3 = { cidr_block = "192.168.3.0/24"},
  }
}

variable "public_subnets" {
  description = "Une carte des sous-réseaux publics à créer"
  type        = map(object({ cidr_block = string, availability_zone = string, map_public_ip = bool }))
  default = {
    public_subnet_1  = { cidr_block = "192.168.1.0/26", availability_zone = "us-east-1a", map_public_ip = true },
    public_subnet_2  = { cidr_block = "192.168.1.64/26", availability_zone = "us-east-1b", map_public_ip = true },
  }
}

variable "nat_name" {
  description = "Le nom du NAT Gateway"
  type        = string
  default     = "my_nat"
}

variable "private_subnets" {
  description = "Une carte des sous-réseaux privés à créer"
  type        = map(object({ cidr_block = string, availability_zone = string, map_public_ip = bool }))
  default = {
    private_subnet_1 = { cidr_block = "192.168.1.128/26", availability_zone = "us-east-1a", map_public_ip = false },
    private_subnet_2 = { cidr_block = "192.168.1.192/26", availability_zone = "us-east-1b", map_public_ip = false },
  }
}

variable "instances" {
  description = "Une carte des instances EC2 à créer"
  type        = map(object({ ami = string, instance_type = string, subnet_id = string }))
  default = {
    instance_1 = { ami = "ami-022e1a32d3f742bd8", instance_type = "t2.micro", subnet_id = "" },
    instance_2 = { ami = "ami-022e1a32d3f742bd8", instance_type = "t2.micro", subnet_id = "" },
  }
}

*/
/*module "aws_vpc" {
  source  = "../modules/vpc/aws"
  vpcs = var.vpcs
}

module "subnets_public" {
  source  = "../modules/subnets/aws"
  vpc_id  = module.aws_vpc.vpc_ids["vpc_1"]
  internet_gateway_id = module.aws_vpc.internet_gateway_ids["vpc_1"]
  subnets = var.public_subnets
}

module "nat_gateway" {
  source           = "../modules/nat/aws"
  name             = var.nat_name
  public_subnet_id = module.subnets_public.subnet_ids["public_subnet_1"]
}

module "subnets_private" {
  source           = "../modules/subnets/aws"
  vpc_id           = module.aws_vpc.vpc_ids["vpc_1"]
  nat_gateway_id   = module.nat_gateway.nat_gateway_id
  subnets = var.private_subnets
}

module "ec2" {
  source = "../modules/vm/aws"
  instances = {
    instance_1 = { ami = var.instances["instance_1"].ami, instance_type = var.instances["instance_1"].instance_type, subnet_id = module.subnets_public.subnet_ids["public_subnet_1"]},
    instance_2 = { ami = var.instances["instance_2"].ami, instance_type = var.instances["instance_2"].instance_type, subnet_id = module.subnets_public.subnet_ids["public_subnet_1"]},
  }
}
*/