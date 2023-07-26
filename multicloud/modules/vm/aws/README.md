## Overview
This module allows the creation of Amazon Elastic Compute Cloud (Amazon EC2) instances in AWS with customizable configurations. It leverages Terraform and the `aws_instance` resource to provision EC2 instances. With this module, you can create multiple EC2 instances with varying specifications in your infrastructure.

## Inputs
The following table outlines the input variables used in this module, along with their types, default values, and whether they are required:

<table>
  <tr>
    <th>Name</th>
    <th>Description</th>
    <th>Type</th>
    <th>Default</th>
    <th>Required</th>
  </tr>
  <tr>
    <td>instances</td>
    <td>A map of EC2 instance configurations</td>
    <td>Map of Objects</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>vpc_ids</td>
    <td>A map that associates VPC names to their respective IDs</td>
    <td>Map</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>vpc_name</td>
    <td>The name of the VPC where the instances will be created</td>
    <td>String</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>subnet_ids</td>
    <td>A map that associates subnet names to their respective IDs</td>
    <td>Map</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
</table>

### The instances map contains the following variables:

<table>
  <tr>
    <th>Name</th>
    <th>Description</th>
    <th>Type</th>
    <th>Default</th>
    <th>Required</th>
  </tr>
  <tr>
    <td>ami</td>
    <td>The ID of the AMI</td>
    <td>String</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>instance_type</td>
    <td>The type of instance to start</td>
    <td>String</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>subnet_name</td>
    <td>The name of the subnet to launch the instance in</td>
    <td>String</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>public_ip</td>
    <td>Associate a public IP address with an instance in a VPC</td>
    <td>Boolean</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>ports</td>
    <td>The ports to be opened on this instance</td>
    <td>List of Strings</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
</table>

### Some instance types to use 
- t2.micro
- t2.small
- t2.medium
- t3.micro
- t3.small
- t3.medium
- m5.large
- m5.xlarge

### Some AMIs to use 
- ami-0c94855ba95c574c8 (Amazon Linux 2 LTS - x86)
- ami-0b41405369376af92 (Amazon Linux 2 LTS - Arm)
- ami-09e67e426f25ce0d7 (Ubuntu Server 20.04 LTS - x86)
- ami-0da96e6f21362f5ff (Ubuntu Server 20.04 LTS - Arm)

## Usage
To utilize this module, include the following block in your Terraform configuration:

```
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

Remember to adapt these properties according to your needs. For example, you may want to change the `instance_type` for more compute-intensive workloads, or adjust the `ports` list to open different ports depending on your application's requirements.

The outputs of this Terraform module include `instance_ids`, which is a map associating the names of the instances to their respective IDs. This output can be used for further configurations or as an input to other resources or modules.

## Outputs
<table>
  <tr>
    <th>Name</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>instance_ids</td>
    <td>A map that provides the IDs of the created instances, mapped by their respective names.</td>
  </tr>
</table>
