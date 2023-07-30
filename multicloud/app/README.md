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

# Azure Terraform Modules - Root Module

This repository contains modules for deploying a multi-tier infrastructure on Microsoft Azure using Terraform.


## Prerequisites

Before using these modules, ensure you have the following prerequisites:

1. **Terraform**: Install Terraform on your local machine. You can download it from the official website: https://www.terraform.io/downloads.html

2. **Azure CLI**: Install the Azure CLI on your local machine to authenticate with Azure. You can download it from the official website: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli

3. **Azure Service Principal**: Create an Azure Service Principal to authenticate Terraform with your Azure subscription. Make sure to store the credentials securely.

4. **Credentials File**: Create a file named `terraform.tfvars` in this directory and provide the required variables as mentioned in the modules' input section. For example:

   ```hcl
   subscription_id = "YOUR_AZURE_SUBSCRIPTION_ID"
  Usage
To use these modules, include the following blocks in your Terraform configuration files:

Azure VPC
# VPC module call
module "azure_vpc" {
  source = "path/to/azure/modules/vpc"

  # VPCs Input
  vpcs = {
    "vpc1" = {
      name = "vpc1"
      address_space = ["10.0.0.0/16"]
      resource_group_name = "my_rg1"
    },
    "vpc2" = {
      name = "vpc2"
      address_space = ["10.1.0.0/16"]
      resource_group_name = "my_rg2"
    },
    "vpc3" = {
      name = "vpc3"
      address_space = ["10.2.0.0/16"]
      resource_group_name = "my_rg3"
    }
  }
}
Azure Subnets
# Subnet module call
module "azure_subnet" {
  source = "path/to/azure/modules/subnets"
  depends_on = [module.azure_vpc] # This module starts after the VPC module finishes executing

  # Subnets Input
  subnets = {
    "subnet1" = {
      name = "subnet1"
      address_prefix = "10.0.1.0/24"
      vpc_name = "vpc1"
    },
    "subnet2" = {
      name = "subnet2"
      address_prefix = "10.0.2.0/24"
      vpc_name = "vpc1"
    }
  }
}
Azure VMs
# VM module call
module "azure_vms" {
  source = "path/to/azure/modules/vm"
  depends_on = [module.azure_vpc, module.azure_subnet] # This module starts after the VPC & Subnet modules finish executing

  # VMs Input
  vms = {
    "vm1" = {
      name = "vm1"
      vm_size = "Standard_B2ms"
      admin_username = "azureuser"
      admin_password = var.password
      os_disk_size_gb = 30
      subnet_name = "subnet1"
      resource_group_name = "my_rg1"
      availability_zone = "1"
      tags = {
        environment = "production"
      }
    },
    "vm2" = {
      name = "vm2"
      vm_size = "Standard_B2s"
      admin_username = "azureuser"
      admin_password = var.password
      os_disk_size_gb = 30
      subnet_name = "subnet2"
      resource_group_name = "my_rg1"
      availability_zone = "1"
      tags = {
        environment = "staging"
      }
    }
  }
}

# Output of the VMs Public IPs
output "azure_vm_ip_out" {
  value = module.azure_vms.vm_public_ips
}
Happy Terraforming!



