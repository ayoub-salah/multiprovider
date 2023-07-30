# Overview
This Terraform module is used to create Azure Virtual Networks (VPCs). It supports creating multiple VPCs with configurable attributes such as address space and resource group.

## Variables
<table>
  <tr>
    <th>Name</th>
    <th>Description</th>
    <th>Type</th>
    <th>Default</th>
  </tr>
  <tr>
    <td>vpcs</td>
    <td>A map of VPC configurations</td>
    <td>map(object)</td>
    <td>N/A</td>
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
    <td>name</td>
    <td>The name of the VPC</td>
    <td>String</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>address_space</td>
    <td>The address space for the VPC (e.g., "10.0.0.0/16")</td>
    <td>List of Strings</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>resource_group_name</td>
    <td>The name of the resource group to which the VPC belongs</td>
    <td>String</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
</table>

## Usage

To utilize this module, include the following block in your Terraform configuration:

```hcl
# VPC module call
module "my_vpc" {
  source = "./modules/vpc/azure"

  # VPCs Input
  vpcs = {
    "vpc1" = {
      name                = "my-vpc-1"
      address_space       = ["10.0.0.0/16"]
      resource_group_name = "my-resource-group"
    },
    "vpc2" = {
      name                = "my-vpc-2"
      address_space       = ["192.168.0.0/16"]
      resource_group_name = "my-resource-group"
    }
  }
}
In the above example, we are using the vpcs variable to define two VPC configurations, vpc1 and vpc2, each with its respective properties.

Remember to customize the VPC configurations according to your requirements.

Outputs
#######
This module will provide the following outputs:

<table>
  <tr>
    <th>Name</th>
    <th>Description</th>
    <th>Type</th>
  </tr>
  <tr>
    <td>vpc_ids</td>
    <td>A map linking the name of each VPC to its Azure resource ID</td>
    <td>Map of Strings</td>
  </tr>
</table>


You can access this output in your Terraform configuration using module.<module-name>.vpc_ids, where <module-name> is the name you've given to the module block in your configuration. For example, if your VPC module is named my_vpc, you would access the output with module.my_vpc.vpc_ids. This map can be useful when configuring resources that need to refer to these VPCs by their Azure resource ID.

With this updated README, your Azure VPC module documentation should be more comprehensive and easier to understand, allowing your team members to use it effectively in your multi-cloud project.
