Overview
This Terraform module is used to create Azure Virtual Networks (VPCs). It supports creating multiple VPCs with configurable attributes such as address space and resource group.
Variables
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
Outputs
<table>
  <tr>
    <th>Name</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>vpc_name</td>
    <td>A map of VPC names</td>
  </tr>
</table>
