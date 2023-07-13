module "aws_vpc" {
  source  = "../modules/vpc/aws"
  /*vpc_cidr = "192.168.1.0/24"
  tags = "Ayoub_vpc"*/
  vpcs = {
    vpc_1 = { cidr_block = "192.168.1.0/24"},
    vpc_2 = { cidr_block = "192.168.2.0/24"},
    vpc_3 = { cidr_block = "192.168.3.0/24"},
  }
}

module "subnets_public" {
  source  = "../modules/subnets/aws"
  vpc_id  = module.aws_vpc.vpc_ids["vpc_1"]
  
  subnets = {
    public_subnet_1  = { cidr_block = "192.168.1.0/26", availability_zone = "us-east-1a", map_public_ip = true },
    public_subnet_2  = { cidr_block = "192.168.1.64/26", availability_zone = "us-east-1b", map_public_ip = true },
  }
}

module "subnets_private" {
  source  = "../modules/subnets/aws"
  vpc_id  = module.aws_vpc.vpc_ids["vpc_1"]
  
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
