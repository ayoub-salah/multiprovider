# azure provider 
Azure Infrastructure Deployment with Terraform
This project aims to simplify the deployment of Azure infrastructure using Terraform. The project is organized into custom modules for Virtual Networks (VPCs), Subnets, and Virtual Machines (VMs). These modules allow for easy configuration and management of Azure resources, providing a seamless experience for provisioning your infrastructure.

Table of Contents
Introduction
Modules
Usage
Prerequisites
Getting Started
Customizing the Deployment
Terraform Commands
Contributing
License
Introduction
The goal of this project is to streamline the process of creating Azure resources such as Virtual Networks, Subnets, and Virtual Machines. Terraform, an infrastructure as code (IaC) tool, is used to define the desired state of the infrastructure and deploy it on the Azure cloud platform.

Modules
The project is divided into the following custom modules:

VPC Module: This module is responsible for creating Virtual Networks (VPCs) on Azure. It allows you to define multiple VPCs with different configurations.

Subnet Module: The Subnet module handles the creation of Subnets within the specified Virtual Networks. You can create multiple subnets with varying configurations using this module.

VM Module: This module is used to deploy Linux Virtual Machines on Azure. It enables you to define multiple VM instances with custom settings.

Usage
To use this project for deploying your Azure infrastructure, follow the steps below:

Prerequisites: Ensure that you have the necessary credentials and permissions to create resources in your Azure subscription.

Customize the Configuration: Modify the variables.tf files in each module to provide the required input values for your infrastructure. Adjust the resource names, locations, IP address ranges, and other settings as per your needs.

Initialize Terraform: Run terraform init to initialize the working directory and download the required Azure provider plugins.

Plan Deployment: Use terraform plan to preview the changes and resources that will be created based on your configuration.

Deploy Infrastructure: If the plan looks correct, execute terraform apply to provision the Azure infrastructure.

Prerequisites
Terraform: Install Terraform from the official website - https://www.terraform.io/downloads.html
Azure Subscription: You must have an active Azure subscription with appropriate permissions to create resources.
Getting Started
Clone this project repository to your local machine:

bash
Copy code
git clone https://github.com/<your-username>/azure-infrastructure-deployment.git
cd azure-infrastructure-deployment
Customize the module configurations in each module's variables.tf file to match your requirements.

Initialize Terraform in the project root directory:

csharp
Copy code
terraform init
Use Terraform to plan and apply the infrastructure deployment:

terraform plan
terraform apply
Customizing the Deployment
To customize the deployment, modify the variables in the module's variables.tf files. Each module has specific variables for configuring the resources it provisions, such as VPCs, Subnets, and Virtual Machines. Refer to the respective variables.tf files for more details.

Terraform Commands
Here are some useful Terraform commands for managing your infrastructure:

terraform init: Initialize the working directory and download provider plugins.
terraform plan: Preview the changes to be applied to the infrastructure.
terraform apply: Apply the changes and create the Azure resources.
terraform destroy: Destroy all created resources and clean up the infrastructure.
Contributing
Contributions to this project are welcome. If you encounter any issues or have suggestions for improvements, please submit a pull request or open an issue on the project repository.
