/modules/vm/azure/README.md
Overview
This module handles the creation of Azure Virtual Machines (VMs). It supports creating multiple VMs with custom configurations, such as size, network settings, and custom initialization data.

#### Inputs
<table>
  <tr>
    <th>Name</th>
    <th>Description</th>
    <th>Type</th>
    <th>Default</th>
  </tr>
  <tr>
    <td>vms</td>
    <td>A map of VM configurations</td>
    <td>map(object)</td>
    <td>N/A</td>
  </tr>
</table>

#### Outputs
<table>
  <tr>
    <th>Name</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>vm_ids</td>
    <td>A map of VM IDs</td>
  </tr>
  <tr>
    <td>public_ip_addresses</td>
    <td>A map of public IP addresses</td>
  </tr>
  <tr>
    <td>private_ip_addresses</td>
    <td>A map of private IP addresses</td>
  </tr>
</table>


Script
The provided script myScript.sh is used to configure the created VMs with Apache and a custom index.html file.

Possible Improvements
For the VPC module, consider adding support for configuring custom DNS settings.
For the Subnet module, consider adding support for associating Network Security Groups (NSGs) to the subnets.
For the VM module, consider adding support for configuring additional data disks and customizing the VM extensions.
For the root module, consider adding support for configuring additional resources such as storage accounts, load balancers, or virtual machine scale sets.
