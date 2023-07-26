## Overview
This Terraform module is designed to create AWS Virtual Private Cloud (VPC) subnets within existing VPCs. It uses the `aws_subnet` and `aws_route_table_association` resources to create and manage the subnets on Amazon Web Services (AWS). By using this module, you can easily create multiple subnets with varying specifications in your infrastructure.

## Inputs
The following table provides an overview of the variables used in this module, along with their types, default values, and whether they are required or not:

<table>
  <tr>
    <th>Name</th>
    <th>Description</th>
    <th>Type</th>
    <th>Default</th>
    <th>Required</th>
  </tr>
  <tr>
    <td>subnets</td>
    <td>A map of subnet configurations</td>
    <td>Map of Objects</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>vpc_ids</td>
    <td>A map that links the name of each VPC to its AWS resource ID</td>
    <td>Map of Strings</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>route_ids</td>
    <td>A map that links the name of each VPC to the AWS resource ID of its Route Table</td>
    <td>Map of Strings</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
</table>

### The Subnets Map contains the following variables: 

<table>
  <tr>
    <th>Name</th>
    <th>Description</th>
    <th>Type</th>
    <th>Default</th>
    <th>Required</th>
  </tr>
  <tr>
    <td>vpc_name</td>
    <td>The name of the existing VPC where the subnet will be created.</td>
    <td>String</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>cidr_block</td>
    <td>The CIDR range for the subnet (e.g., "10.0.0.0/24").</td>
    <td>List of Strings</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>map_public_ip</td>
    <td>Boolean flag to enable/disable automatic assignment of a public IP when launching instances in this subnet.</td>
    <td>Bool</td>
    <td>false</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>availability_zone</td>
    <td>The availability zone where the subnet will be created.</td>
    <td>String</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
</table>

## Usage 
To use this module, include the following block in your Terraform configuration:

```
#Subnet module call
module "my_subnet" {
  source = "../modules/subnets/aws"

  #VPC IDs from the VPC module
  vpc_ids = module.my_vpc.vpc_ids

  #Route IDs from the VPC module
  route_ids = module.my_vpc.public_route_table_ids

  #Subnets Input
  subnets = {
    "public_subnet_1" = {
      vpc_name = "vpc1"
      cidr_block = ["10.0.1.0/24"]
      map_public_ip = true
      availability_zone = "us-east-1a"
    },
    "public_subnet_2" = {
      vpc_name = "vpc1"
      cidr_block = ["10.0.2.0/24"]
      map_public_ip = true
      availability_zone = "us-east-1b"
    }
  }
}
```
In the above example, we are using the `subnets` variable to define two subnet configurations, `public_subnet_1` and `public_subnet_2`, each with its respective properties. The subnets will be created in the specified availability zones within the existing VPCs defined in the `my_vpc` module.

Remember to customize the subnet configurations according to your requirements.

## Outputs
This module will provide the following output:

<table>
  <tr>
    <th>Name</th>
    <th>Description</th>
    <th>Type</th>
  </tr>
  <tr>
    <td>subnet_ids</td>
    <td>A map linking the name of each subnet to its AWS resource ID</td>
    <td>Map of Strings</td>
  </tr>
</table>

You can access this output in your Terraform configuration using `module.<module-name>.subnet_ids`, where `<module-name>` is the name you've given to the module block in your configuration. For example, if your subnet module is named `my_subnet`, you would access the output with `module.my_subnet.subnet_ids`. This map can be useful when configuring resources that need to refer to these subnets by their AWS resource ID.
