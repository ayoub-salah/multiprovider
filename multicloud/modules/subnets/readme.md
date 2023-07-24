Subnet Module for Azure Virtual Network
This Terraform module simplifies the process of creating subnets within an Azure Virtual Network (VNet). It allows you to define multiple subnets with different configurations using a single set of variables.

Module Files
main.tf: This file contains the Terraform configuration for creating Azure subnets. It utilizes the azurerm_subnet resource to provision the subnets within the specified Azure Virtual Network.

variables.tf: In this file, you can define the input variables used by the subnet module. The subnets variable is a map that holds the configuration details for each subnet to be created, including the subnet name, address prefixes, and the resource group in which the subnet will be created. The vpc_name variable allows you to specify the name of the existing Azure Virtual Network in which the subnets will be deployed.

outputs.tf: The outputs file defines the information that will be shown after deploying the subnet module. It includes the IDs of the created subnets.

Module Usage
To use this Subnet module, follow these steps:

Include the module in your Terraform configuration by referencing the module source.

Define the required input variables in your main Terraform configuration or create a separate terraform.tfvars file to provide values for the module variables.

Initialize the Terraform working directory by running terraform init.

Plan the deployment to preview the changes and resources that will be created using terraform plan.

If the plan looks correct, deploy the subnets by executing terraform apply.

After successful deployment, Terraform will display the outputs specified in outputs.tf, including the IDs of the created subnets.
