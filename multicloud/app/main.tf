module "vpc_aws" {
  source  = "../modules/vpc/aws"
  vpcs = {
    vpc1 = {cidr_block = ["192.168.1.0/24"], availability_zone  = "East US" },
    vpc2 = {cidr_block = ["192.168.2.0/24"], availability_zone = "East US" },
    vpc3 = {cidr_block = ["192.168.3.0/24"], availability_zone  = "East US" },
  }
}

module "subnets_public_aws" {
  source  = "../modules/subnets/aws"
  //internet_gateway_id = module.vpc_aws[0].internet_gateway_ids[var.vpc_id]
  vpc_ids = module.vpc_aws.vpc_ids
  subnets = {
    public_subnet_1  = { cidr_block = ["192.168.1.0/26"], availability_zone = "us-east-1a", map_public_ip = true, vpc_name = "vpc1" },
    public_subnet_2  = { cidr_block = ["192.168.1.64/26"], availability_zone = "us-east-1b", map_public_ip = true, vpc_name = "vpc1" },
  }
}

module "vms_aws" {
  source = "../modules/vm/aws"
  subnet_ids = module.subnets_public_aws.subnet_ids
  instances = {
    instance_1 = { ami = "ami-022e1a32d3f742bd8", instance_type = "t2.micro", subnet_name = "public_subnet_1" },
    instance_2 = { ami = "ami-022e1a32d3f742bd8", instance_type = "t2.micro", subnet_name = "public_subnet_1"},
  }
}
/*
module "vpc_azure" {
  source = "../modules/vpc/azure"
  //rg     = var.rg
  vpcs   =  {
    vpc1 = {
      address_space = ["192.168.1.0/24"] 
      location      = "East US"
      resource_group = "1-93985c2a-playground-sandbox"
    }
    vpc2 = {
      address_space = ["192.168.2.0/24"]
      location      = "East US"
      resource_group = "1-93985c2a-playground-sandbox"
    }
    vpc3 = {
      address_space = ["192.168.3.0/24"]
      location      = "East US"
      resource_group = "1-93985c2a-playground-sandbox"
    }
  }
}
*/

/*
module "subnets_public_azure" {
  source  = "../modules/subnets/azure"
  vpc_name  = module.vpc_azure[0].vpc_name[var.vpc_name]
  rg = var.rg
  subnets = {
    public_subnet_1  = { cidr_block = ["192.168.1.0/26"], availability_zone = "us-east-1a", map_public_ip = true, vpc_name = "vpc1" },
    public_subnet_2  = { cidr_block = ["192.168.1.64/26"], availability_zone = "us-east-1b", map_public_ip = true, vpc_name = "vpc1" },
  }
}
*/