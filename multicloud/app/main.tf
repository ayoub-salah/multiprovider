module "aws_vpc" {
  source  = "../modules/vpc/aws"
  vpc_cidr = "192.168.1.0/24"
  tags = "Ayoub_vpc"
}

module "subnets" {
  source  = "../modules/subnets/aws"
  vpc_id  = module.aws_vpc.vpc_id
  
  subnets = {
    public_subnet_1  = { cidr_block = "192.168.1.0/26", availability_zone = "us-east-1a", map_public_ip = true },
    public_subnet_2  = { cidr_block = "192.168.1.64/26", availability_zone = "us-east-1b", map_public_ip = true },
    private_subnet_1 = { cidr_block = "192.168.1.128/26", availability_zone = "us-east-1a", map_public_ip = false },
    private_subnet_2 = { cidr_block = "192.168.1.192/26", availability_zone = "us-east-1b", map_public_ip = false },
  }
}