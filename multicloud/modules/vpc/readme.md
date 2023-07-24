VPC (Virtual Private Cloud) Module for Azure
This Terraform module simplifies the process of creating an Azure Virtual Private Cloud (VPC), also known as a Virtual Network. It allows you to define multiple VPCs with different configurations using a single set of variables.

Module Files
main.tf: This file contains the Terraform configuration for creating Azure Virtual Networks. It utilizes the azurerm_virtual_network resource to provision the VPCs with the specified configurations, such as name, address space, resource group, and location.

variables.tf: In this file, you can define the input variables used by the VPC module. The vpcs variable is a map that holds the configuration details for each VPC to be created. It includes the VPC name, address space, resource group, and location.

outputs.tf: The outputs file defines the information that will be shown after deploying the VPC module. It includes the names of the created VPCs.

Module Usage
To use this VPC module, follow these steps:

Include the module in your Terraform configuration by referencing the module source.

Define the required input variables in your main Terraform configuration or create a separate terraform.tfvars file to provide values for the module variables.

Initialize the Terraform working directory by running terraform init.

Plan the deployment to preview the changes and resources that will be created using terraform plan.

If the plan looks correct, deploy the VPCs by executing terraform apply.

After successful deployment, Terraform will display the outputs specified in outputs.tf, including the names of the created VPCs.
