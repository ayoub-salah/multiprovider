## Overview
This module is designed to create Google Compute Engine networks (VPCs) with customizable configurations. It utilizes Terraform and the google_compute_network resource to create the VPCs on the Google Cloud Platform (GCP). By using this module, you can easily create multiple VPCs with varying specifications in your infrastructure.

## Inputs
The following table provides an overview of the variables used in this module, along with their types ,default values, and whether they are required or not:

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
    <td>name</td>
    <td>The name of the VPC.</td>
    <td>String</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
</table>

## Usage 
To use this module, include the following block in your Terraform configuration:

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
    }
  }

}
 ```

In the above example, we are using the vpcs variable to define two VPC configurations, vpc1 and vpc2, each with its respective properties.

Remember to customize the VPC configurations according to your requirements.

## Outputs
N/A