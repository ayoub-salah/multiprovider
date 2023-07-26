Project Overview
This Terraform project aims to create a unified infrastructure on Azure, consisting of Virtual Networks (VPCs), subnets, and Virtual Machines (VMs). The project is organized into the following modules:

/modules/vpc/azure: This module is responsible for creating Azure Virtual Networks (VPCs) and supports creating multiple VPCs with custom attributes.

/modules/subnet/azure: This module is used to create subnets in the previously created Virtual Networks. It allows creating multiple subnets with configurable CIDR blocks and associations with existing VPCs.

/modules/vm/azure: This module handles the creation of Azure Virtual Machines (VMs). It supports creating multiple VMs with custom configurations, such as size, network settings, and custom initialization data.

Each module has its own README.md with detailed information on how to use it, including input variables, outputs, and usage examples.

Possible Improvements
/modules/vpc/azure:

Support custom tags for Virtual Networks to add additional metadata , dynamic blocks and nested dynamic blocks .
Implement route tables and peering options for inter-VPC communication.
/modules/subnet/azure:

Allow creating Network Security Groups (NSGs) and associating them with subnets.
Support associating subnets with application gateways or load balancers.
/modules/vm/azure:
Add dynamic Operating System and hardware ressources like : Ram , disk_type , group of vm must join (active directory)
Implement data disk creation options for VMs with additional storage requirements.
Dynamically choose between ssh or password . 

Overall, this Terraform project is a great step towards creating a unified infrastructure on Azure, making it easier to manage resources and deploy applications across different cloud providers. If you have any questions or need further assistance, feel free to ask!
