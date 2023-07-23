module "vpc_azure" {
  count = var.deploy_azure ? 1 : 0
  source = "../modules/vpc/azure"
  //rg     = var.rg
  vpcs   = var.vpcs
}

module "vpc_aws" {
  count = var.deploy_aws ? 1 : 0
  source  = "../modules/vpc/aws"
  vpcs    = var.vpcs
}

module "subnets_public_aws" {
  count = var.deploy_aws ? 1 : 0

  source  = "../modules/subnets/aws"
  vpc_id  = module.vpc_aws[0].vpc_ids[var.vpc_id]
  internet_gateway_id = module.vpc_aws[0].internet_gateway_ids[var.vpc_id] //car les deux map ils ont la meme clé pour chaque vpc une gateway
  subnets = var.subnets //on doit la changer ---> subnets_public
}
module "subnets_public_azure" {
  count = var.deploy_azure ? 1 : 0

  source  = "../modules/subnets/azure"
  vpc_name  = module.vpc_azure[0].vpc_name[var.vpc_name]
  rg = var.rg
  subnets = var.subnets //on doit la changer ---> subnets_public
}












/*
module "aws_vpc" {
  source  = "../modules/vpc/aws"

  vpcs = {
    vpc_1 = { cidr_block = "192.168.1.0/24"},
    vpc_2 = { cidr_block = "192.168.2.0/24"},
    vpc_3 = { cidr_block = "192.168.3.0/24"},
  }
}

module "subnets_public" {
  source  = "../modules/subnets/aws"
  vpc_id  = module.aws_vpc.vpc_ids["vpc_1"]
  internet_gateway_id = module.aws_vpc.internet_gateway_ids["vpc_1"]
  
  subnets = {
    public_subnet_1  = { cidr_block = "192.168.1.0/26", availability_zone = "us-east-1a", map_public_ip = true },
    public_subnet_2  = { cidr_block = "192.168.1.64/26", availability_zone = "us-east-1b", map_public_ip = true },
  }
}

module "nat_gateway" {
  source           = "../modules/nat/aws"
  name             = "my_nat"
  public_subnet_id = module.subnets_public.subnet_ids["public_subnet_1"]
}

module "subnets_private" {
  source           = "../modules/subnets/aws"
  vpc_id           = module.aws_vpc.vpc_ids["vpc_1"]
  nat_gateway_id   = module.nat_gateway.nat_gateway_id
  subnets = {
    private_subnet_1 = { cidr_block = "192.168.1.128/26", availability_zone = "us-east-1a", map_public_ip = false },
    private_subnet_2 = { cidr_block = "192.168.1.192/26", availability_zone = "us-east-1b", map_public_ip = false },
  }
}

module "ec2" {
  source = "../modules/vm/aws"

  instances = {
    instance_1 = { ami = "ami-022e1a32d3f742bd8", instance_type = "t2.micro", subnet_id = module.subnets_public.subnet_ids["public_subnet_1"]},
    instance_2 = { ami = "ami-022e1a32d3f742bd8", instance_type = "t2.micro", subnet_id = module.subnets_public.subnet_ids["public_subnet_1"]},
  }
}
*/