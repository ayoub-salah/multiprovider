## Overview
This Terraform module is designed to create Google Compute Engine subnetworks (subnets) within existing VPCs. It uses the google_compute_subnetwork resource to create the subnets on the Google Cloud Platform (GCP). By utilizing this module, you can easily create multiple subnets with varying specifications in your infrastructure.

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
    <td>name</td>
    <td>The name of the Subnet.</td>
    <td>String</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>ip_cidr_range</td>
    <td>The CIDR range for the subnet (e.g., "10.0.0.0/24").</td>
    <td>String</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>region</td>
    <td>The region where the subnet will be created.</td>
    <td>String</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>vpc_name</td>
    <td>The name of the existing VPC where the subnet will be created.</td>
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

In the above example, we are using the subnets variable to define two subnet configurations, subnet1 and subnet2, each with its respective properties. The subnets will be created in the specified regions within the existing VPCs defined in the my_vpc module.

Remember to customize the subnet configurations according to your requirements.

## Outputs
N/A