# Overview
This Terraform module is used to create Azure Virtual Networks (VPCs). It supports creating multiple VPCs with configurable attributes such as address space and resource group.

## Variables
### vpcs
A map of VPC configurations.

| Name                 | Description                                            | Type       | Default | Required |
|----------------------|--------------------------------------------------------|------------|---------|----------|
| resource_group_name  | The name of the resource group where the VPC will be created. | String     | N/A     | Yes      |
| address_space        | A list of address spaces to be used by the VPC.        | List       | N/A     | Yes      |

## Usage
To utilize this module, include the following block in your Terraform configuration:

```hcl
# VPC module call
module "my_vpc" {
  source = "./modules/vpc/azure"

  # VPCs Input
  vpcs = {
    "vpc1" = {
      resource_group_name = "my_resource_group"
      address_space       = ["10.0.0.0/16"]
    },
    "vpc2" = {
      resource_group_name = "my_resource_group"
      address_space       = ["192.168.0.0/16"]
    }
  }
}
In the above example, we are using the vpcs variable to define two VPC configurations, vpc1 and vpc2, each with its respective properties.

Remember to customize the VPC configurations according to your requirements.

Outputs
This module will provide the following outputs:

vpc_names
A map of VPC names.

You can access this output in your Terraform configuration using module.<module-name>.vpc_names, where <module-name> is the name you've given to the module block in your configuration. For example, if your VPC module is named my_vpc, you would access the output with module.my_vpc.vpc_names.
