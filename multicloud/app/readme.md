Root Module for Azure Infrastructure Deployment
This Terraform root module is used to deploy an Azure infrastructure with Virtual Networks, Subnets, and Virtual Machines (VMs). It makes use of custom modules to organize and simplify the provisioning process. Below is a brief overview of the root module and its components.

Files
main.tf: The main Terraform configuration file that defines the overall infrastructure and uses custom modules to create resources such as Virtual Networks, Subnets, and Virtual Machines.

variables.tf: This file contains the input variables used in the root module. These variables allow you to customize the deployment by providing values for the resource group, subscription ID, location, and other parameters.

output.tf: The outputs file defines the information that will be displayed after the Terraform deployment. It includes the names of the Virtual Networks (VPCs), the IDs of the Subnets, and the public and private IP addresses of the Virtual Machines.

Usage
To deploy your Azure infrastructure using this root module, follow these steps:

Customize the variables in variables.tf to match your Azure environment and requirements. Provide the necessary values for the resource group, subscription ID, location, etc.

Ensure you have the required Azure credentials and permissions to create resources in the target Azure subscription.

Run terraform init to initialize the working directory and download the necessary Azure provider plugins.

Use terraform plan to preview the changes and resources that will be created based on your configuration.

If the plan looks correct, execute terraform apply to provision the Virtual Networks, Subnets, and Virtual Machines on Azure.

After successful deployment, Terraform will display the outputs specified in output.tf, including the names of the created Virtual Networks, the IDs of the Subnets, and the IP addresses of the Virtual Machines.

Note
Please review your configurations carefully before executing Terraform commands to avoid unintended consequences. Ensure that you have properly set up your Azure credentials and have the necessary permissions to create resources in the target Azure subscription.

For more information about Terraform and the Azure provider, refer to the official documentation:

Terraform: https://www.terraform.io/docs/index.html
Azure Provider for Terraform: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
Happy provisioning!
