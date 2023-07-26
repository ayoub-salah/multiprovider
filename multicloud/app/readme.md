/app/ (Root Module)
Overview
The root module of the Terraform project for Azure, allowing you to create a unified infrastructure consisting of Virtual Networks (VPCs), subnets, and Virtual Machines (VMs) in Azure.

Usage
1. First, define your desired variables in var.tf .

2. Create the Azure provider configuration in main.tf .

3. Use the VPC module to create Virtual Networks .
 
4. Use the Subnet module to create subnets in the Virtual Networks .

5. Use the VM module to create Virtual Machines in the subnets .
   
<h2>Variables</h2>
<table>
  <tr>
    <th>Name</th>
    <th>Description</th>
    <th>Type</th>
    <th>Default</th>
  </tr>
  <tr>
    <td>rg</td>
    <td>The name of the resource group to create</td>
    <td>string</td>
    <td>N/A</td>
  </tr>
  <tr>
    <td>subscription_id</td>
    <td>The Azure subscription ID</td>
    <td>string</td>
    <td>N/A</td>
  </tr>
  <tr>
    <td>availability_zone</td>
    <td>The desired availability zone</td>
    <td>string</td>
    <td>"East US"</td>
  </tr>
</table>
