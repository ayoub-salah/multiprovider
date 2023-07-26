Overview
This module is used to create subnets in the previously created Virtual Networks. It allows creating multiple subnets with configurable CIDR blocks and associations with existing VPCs.

Variables
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
Outputs
<table>
  <tr>
    <th>Name</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>subnet_ids</td>
    <td>A map of subnet IDs</td>
  </tr>
</table>
