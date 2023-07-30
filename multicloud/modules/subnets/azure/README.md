Overview
This Terraform module is designed to create Azure subnets within existing Virtual Networks (VNet). It allows creating multiple subnets with configurable CIDR blocks and associations with existing VNets.

Variables
The following table provides an overview of the variables used in this module, along with their types and default values:
## Variables
<table>
  <tr>
    <th>Name</th>
    <th>Description</th>
    <th>Type</th>
    <th>Default</th>
  </tr>
  <tr>
    <td>subnets</td>
    <td>A map of subnet configurations</td>
    <td>map(object)</td>
    <td>N/A</td>
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
    <td>vnet_name</td>
    <td>The name of the existing VNet where the subnet will be created.</td>
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
    <td>is_public</td>
    <td>Boolean flag to indicate if the subnet allows public IPs.</td>
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
Usage
To use this module, include the following block in your Terraform configuration:
# Subnet module call
module "my_subnet" {
  source = "./modules/subnet/azure"

  # VNet Name from the VNet module
  vnet_name = module.my_vnet.vnet_name

  # Subnets Input
  subnets = {
    "public_subnet_1" = {
      vnet_name          = "my_vnet"
      cidr_block         = "10.0.1.0/24"
      is_public          = true
      availability_zone  = "eastus"
    },
    "private_subnet_1" = {
      vnet_name          = "my_vnet"
      cidr_block         = "10.0.2.0/24"
      is_public          = false
      availability_zone  = "eastus"
    }
  }
}
In the above example, we are using the subnets variable to define two subnet configurations, public_subnet_1 and private_subnet_1, each with its respective properties. The subnets will be created in the specified availability zones within the existing VNets defined in the my_vnet module.

Remember to customize the subnet configurations according to your requirements.
Outputs
This module will provide the following output:
<table>
  <tr>
    <th>Name</th>
    <th>Description</th>
    <th>Type</th>
  </tr>
  <tr>
    <td>subnet_ids</td>
    <td>A map linking the name of each subnet to its Azure resource ID</td>
    <td>Map of Strings</td>
  </tr>
</table>
You can access this output in your Terraform configuration using module.<module-name>.subnet_ids, where <module-name> is the name you've given to the module block in your configuration. For example, if your subnet module is named my_subnet, you would access the output with module.my_subnet.subnet_ids. This map can be useful when configuring resources that need to refer to these subnets by their Azure resource ID.

With this updated README, your Azure subnet module documentation should be more comprehensive and easier to understand, allowing your team members to use it effectively in your multi-cloud project.
