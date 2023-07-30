## GCP prototypes:
Here are the blocks you need to implement in the app/main.tf to create the desired ressource:
### DO not forget to provide your credentials file as app/creds.json AND your providers block in the providers.tf file
#### CHANGE THE VARIABLES TO YOUR NEEDS.
### VPC
```
#VPC module call
module "my_vpc" {
  source = "../modules/vpc/gcp"

  #Vpcs Input
  vpcs = {
    "vpc1" = {
      name   = "vpc1"    
    },
    "vpc2" = {
      name   = "vpc2"
    },
    "vpc3" = {
      name   = "vpc3"
    }
  }

}
```

### Subnets

```
#Subnet module call
module "my_subnet" {
  source = "../modules/subnets/gcp"
  depends_on = [module.my_vpc]    #this module starts after vpc module finishes executing 
  
  #Subnets Input
  subnets = {
    "subnet1" = {
      name = "sub1"
      ip_cidr_range = "10.169.0.0/20"
      region = "us-east1"
      vpc_name = "vpc2"
    },
    "subnet2" = {
      name = "sub2"
      ip_cidr_range = "10.167.0.0/20"
      region = "us-east1"
      vpc_name = "vpc1"
    }
  }
}
```

### VMs
#### For Vms, you can edit the script.sh file to execute the commands you want when the machine gets created, you can also created other .sh files to use seperate scripts for each vm created you just need to give the path in the inputs.

```
#Vm module call
module "my_vms" {
  source = "../modules/vm/gcp"
  depends_on = [module.my_vpc, module.my_subnet] #this module starts after vpc & subnet modules finish executing 
  network = "vpc2"    #Vpc name
  
  #Vms Input
  vms = {
    "vm1" = {
      name = "vm1"
      image = "debian-cloud/debian-11"
      type = "e2-medium"
      ports = ["80","22","443"]
      zone = "us-east1-b"
      subnet = "sub1"
      userdata_script = "script.sh"
    },
    "vm2" = {
      name = "vm2"
      image = "debian-cloud/debian-11"
      type = "custom-2-8192"
      ports = ["22"]
      zone = "us-east1-b"
      subnet = "sub1"
      userdata_script = "script.sh"
    }

  }
}

#Output of the vms public IPs
output "vm_ip_out" {
  value = module.my_vms.vm_ips   
}
```

## AWS Terraform Modules

This repository contains modules for deploying a multi-tier infrastructure on Amazon Web Services (AWS) using Terraform.

## AWS VPC

Here is the block you need to implement in your Terraform main configuration file (`main.tf`) to create the desired VPC resources. Make sure to change the variables according to your requirements.

**Important: Don't forget to add the necessary AWS provider block in the `providers.tf` file located in the same directory as your `main.tf` file.**

```
# VPC module call
module "vpc_aws" {
  source  = "../modules/vpc/aws"

  vpcs = {
    vpc1 = {cidr_block = ["192.168.1.0/24"]},
    vpc2 = {cidr_block = ["192.168.2.0/24"]},
    vpc3 = {cidr_block = ["192.168.3.0/24"]},
  }
}
```

## AWS Public Subnets

Here is the block you need to implement in your `main.tf` file to create the desired public subnet resources. Note that you will need to provide the `vpc_ids`, `internet_gateway_ids`, and `route_ids` from the VPC module.

```
# Public Subnet module call
module "subnets_public_aws" {
  source  = "../modules/subnets/aws"

  vpc_ids = module.vpc_aws.vpc_ids
  internet_gateway_ids = module.vpc_aws.internet_gateway_ids
  route_ids = module.vpc_aws.route_table_ids
  
  subnets = {
    public_subnet_1  = { cidr_block = ["192.168.1.0/26"], availability_zone = "us-east-1a", map_public_ip = true, vpc_name = "vpc1" },
    public_subnet_2  = { cidr_block = ["192.168.1.64/26"], availability_zone = "us-east-1b", map_public_ip = true, vpc_name = "vpc1"},
  }
}
```

## AWS EC2 Instances (Virtual Machines)

Here is the block you need to implement in your `main.tf` file to create the desired EC2 instances (VMs). Make sure to change the `instances` configuration according to your requirements.

```
# EC2 Instances module call
module "vms_aws" {
  source = "../modules/vm/aws"

  vpc_name = "vpc1"
  vpc_ids = module.vpc_aws.vpc_ids
  subnet_ids = module.subnets_public_aws.subnet_ids
  
  instances = {
    instance_1 = { ami = "ami-022e1a32d3f742bd8", instance_type = "t2.micro", subnet_name = "public_subnet_1", public_ip = true, ports = [22,80,443] },
    instance_2 = { ami = "ami-022e1a32d3f742bd8", instance_type = "t2.micro", subnet_name = "public_subnet_1", public_ip = true, ports = [22,80,443] },
  }
}
```

Remember, always verify that your configurations meet your requirements and comply with your company or organization's standards and policies.

For any further clarifications or modifications, feel free to raise an issue or submit a pull request.

Happy Terraforming!

Azure Terraform Modules - Root Module
This repository contains modules for deploying a multi-tier infrastructure on Microsoft Azure using Terraform.

Azure Virtual Networks (VPC)
To create Azure Virtual Networks (VPCs) with customizable configurations, use the following block in your Terraform main configuration file (main.tf). Don't forget to change the variables according to your requirements.

Important: Ensure you have provided your credentials file as app/creds.json and define the necessary Azure provider block in the providers.tf file located in the same directory as your main.tf file.
# VPC module call
module "my_vpc" {
  source = "../modules/vpc/azure"

  # VPCs Input
  vpcs = {
    "vpc1" = {
      address_space = ["10.0.0.0/16"]
      resource_group_name = "my_resource_group1"
    },
    "vpc2" = {
      address_space = ["192.168.0.0/16"]
      resource_group_name = "my_resource_group2"
    },
    "vpc3" = {
      address_space = ["172.16.0.0/16"]
      resource_group_name = "my_resource_group3"
    }
  }
}
Azure Subnets
To create Azure subnets within existing VPCs, use the following block in your main.tf file. Make sure to provide the vpc_name parameter based on the VPC names defined in the VPC module block.
# Subnet module call
module "my_subnet" {
  source = "../modules/subnets/azure"
  depends_on = [module.my_vpc]  # This module starts after the VPC module finishes executing
  
  # Subnets Input
  subnets = {
    "subnet1" = {
      vpc_name = "vpc2"
      cidr_block = ["10.0.1.0/24"]
    },
    "subnet2" = {
      vpc_name = "vpc1"
      cidr_block = ["10.0.2.0/24"]
    }
  }
}
Azure Virtual Machines (VMs)
To create Azure Virtual Machines (VMs) with customizable configurations, use the following block in your main.tf file. Make sure to change the vms configuration according to your requirements.
# VM module call
module "my_vms" {
  source = "../modules/vm/azure"
  depends_on = [module.my_vpc, module.my_subnet]  # This module starts after VPC & Subnet modules finish executing
  network = "vpc2"  # VPC name

  # VMs Input
  vms = {
    "vm1" = {
      vm_size = "Standard_B1s"
      subnet_name = "subnet1"
      os_disk_size_gb = 30
      image_publisher = "Canonical"
      image_offer = "UbuntuServer"
      image_sku = "18.04-LTS"
      admin_username = "azureuser"
      admin_ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC..."
      tags = {
        Environment = "Production"
        Project = "MyApp"
      }
    },
    "vm2" = {
      vm_size = "Standard_DS1_v2"
      subnet_name = "subnet1"
      os_disk_size_gb = 30
      image_publisher = "Canonical"
      image_offer = "UbuntuServer"
      image_sku = "18.04-LTS"
      admin_username = "azureuser"
      admin_ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC..."
      tags = {
        Environment = "Development"
        Project = "MyApp"
      }
    }
  }
}

# Output of the VMs public IPs
output "vm_ip_out" {
  value = module.my_vms.vm_public_ips
}
Remember to always verify that your configurations meet your requirements and comply with your company or organization's standards and policies.

For any further clarifications or modifications, feel free to raise an issue or submit a pull request.

Happy Terraforming!
