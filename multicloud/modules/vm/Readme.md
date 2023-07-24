Azure Virtual Machine (VM) Module
This Terraform module provides an easy and reusable way to deploy Linux virtual machines on Microsoft Azure. The module allows you to define multiple VM instances with different configurations using a single set of variables.

Module Files
main.tf: This file contains the Terraform configuration for creating Azure Linux virtual machines. It utilizes the azurerm_linux_virtual_machine resource to provision the VM instances.

variables.tf: In this file, you can define the input variables used by the VM module. These variables allow you to customize the VM instances according to your requirements, such as specifying the number of VMs, VM sizes, OS disk settings, network configurations, and more.

outputs.tf: The outputs file defines the information that will be shown after deploying the VM module. It includes the VM IDs, public IP addresses, and private IP addresses of each VM instance.

Module Usage
To use this VM module, follow these steps:

Include the module in your Terraform configuration by referencing the module source.

Define the required input variables in your main Terraform configuration or create a separate terraform.tfvars file to provide values for the module variables.

Initialize the Terraform working directory by running terraform init.

Plan the deployment to preview the changes and resources that will be created using terraform plan.

If the plan looks correct, deploy the VM instances by executing terraform apply.

After successful deployment, Terraform will display the outputs specified in outputs.tf, including the VM IDs, public IP addresses, and private IP addresses of each VM.
