## Overview
This module is designed to create AWS VPCs (Virtual Private Clouds) with customizable configurations. It uses Terraform and the `aws_vpc`, `aws_internet_gateway`, and `aws_route_table` resources to create the VPCs on the Amazon Web Services (AWS) platform. By utilizing this module, you can effortlessly establish multiple VPCs with various configurations in your infrastructure.

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
    <td>vpcs</td>
    <td>A map of VPC configurations</td>
    <td>Map of Objects</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
</table>

### The VPC Map contains the following variables:

<table>
  <tr>
    <th>Name</th>
    <th>Description</th>
    <th>Type</th>
    <th>Default</th>
    <th>Required</th>
  </tr>
  <tr>
    <td>cidr_block</td>
    <td>The CIDR block for the VPC</td>
    <td>List of Strings</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
</table>

## Usage 

To utilize this module, include the following block in your Terraform configuration:

```
# VPC module call
module "my_vpc" {
  source = "../modules/vpc/aws"

  # VPCs Input
  vpcs = {
    "vpc1" = {
      cidr_block   = ["10.0.0.0/16"]  
    },
    "vpc2" = {
      cidr_block   = ["192.168.0.0/16"]
    }
  }
}
```
In the above example, we are using the vpcs variable to define two VPC configurations, vpc1 and vpc2, each with its respective properties.

Remember to customize the VPC configurations according to your requirements.

## Outputs

The following outputs are available from this module:

<table>
  <tr>
    <th>Name</th>
    <th>Description</th>
    <th>Type</th>
  </tr>
  <tr>
    <td>vpc_ids</td>
    <td>A map that links the name of each VPC to its AWS resource ID</td>
    <td>map(string)</td>
  </tr>
  <tr>
    <td>internet_gateway_ids</td>
    <td>A map that links the name of each VPC to the AWS resource ID of its Internet Gateway</td>
    <td>map(string)</td>
  </tr>
  <tr>
    <td>public_route_table_ids</td>
    <td>A map that links the name of each VPC to the AWS resource ID of its public Route Table</td>
    <td>map(string)</td>
  </tr>
</table>

To access these outputs in your Terraform configuration, you can use expressions like `module.vpc.vpc_ids` or `module.vpc.public_route_table_ids`.

Example:

```
output "vpc_ids" {
  value = module.my_vpc.vpc_ids
}

output "public_route_table_ids" {
  value = module.my_vpc.public_route_table_ids
}
```
