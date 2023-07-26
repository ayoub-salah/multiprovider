## Overview
This module enables the creation of Google Compute Engine virtual machines (VMs) with customizable configurations. It leverages Terraform and the google_compute_instance resource to provision VMs on the Google Cloud Platform (GCP). With this module, you can effortlessly create multiple VM instances with varying specifications in your infrastructure.

## Inputs
The table below outlines the variables used in this module, along with their types, default values, and whether they are required or not:

<table>
  <tr>
    <th>Name</th>
    <th>Description</th>
    <th>Type</th>
    <th>Default</th>
    <th>Required</th>
  </tr>
  <tr>
    <td>vms</td>
    <td>A map of VM configurations</td>
    <td>Map of Objects</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>network</td>
    <td>The name of the network where the VMs will be created</td>
    <td>String</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
</table>

### The VM Map contains the following variables:

<table>
  <tr>
    <th>Name</th>
    <th>Description</th>
    <th>Type</th>
    <th>Default</th>
    <th>Required</th>
  </tr>
  <tr>
    <td>name</td>
    <td>The name of the VM</td>
    <td>String</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>type</td>
    <td>The machine type for the VM (e.g., e2-medium)</td>
    <td>String</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>zone</td>
    <td>The zone where the VM will be located</td>
    <td>String</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>image</td>
    <td>The VM image to use for the boot disk</td>
    <td>String</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>subnet</td>
    <td>The name of the subnetwork for the VM</td>
    <td>String</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>userdata_script</td>
    <td>The file path to the script that will run on VM startup</td>
    <td>String</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>ports</td>
    <td>The ports to open on this Virtual Machine (Firewall)</td>
    <td>List of Strings</td>
    <td>N/A</td>
    <td>Yes</td>
  </tr>
</table>

### Machine Type explained :
You can either use standard Machine types like :

#### _e2-standard-2:_

- 2 vCPUs
- 8 GB RAM
- E2 series, second generation general-purpose machine type
#### _n1-standard-4:_

- 4 vCPUs
- 15 GB RAM
- N1 series, first generation general-purpose machine type
#### _n2-standard-8:_

- 8 vCPUs
- 32 GB RAM
- N2 series, second generation general-purpose machine type
#### _e2-medium:_

- 2 vCPUs
- 4 GB RAM
- E2 series, second generation general-purpose machine type
#### _n1-highcpu-16:_

- 16 vCPUs
- 14.4 GB RAM
- N1 series, first generation high-CPU machine type 

___ 

Or use custom machine types by doing the following:
- #### custom-2-8192

-The "2" is the number of CPUs we want.\
-The "8192" is the RAM we want for our machine (8gb RAM)

Change both numbers based on your needs.

- <u>PS:</u> There is a limit of 6.5 GB per CPU unless you add extended memory. You must do this explicitly by adding the suffix -ext, e.g. custom-2-15360-ext for 2 vCPU and 15 GB of memory.


### Some images to use 
- debian-cloud/debian-10
- ubuntu-os-cloud/ubuntu-2004-lts
- centos-cloud/centos-8



## Usage
To utilize this module, include the following block in your Terraform configuration:

```
#Vm module call
module "my_vms" {
  source = "../modules/vm/gcp"
  depends_on = [module.my_vpc, module.my_subnet] #this module starts after vpc & subnet modules finish executing 
  network = "vpc2"    #Vpc name
  
  #Vms Input
  vms = {
    "vm1" = {
      name = "vm1"
      image = "debian-cloud/debian-11"
      type = "e2-medium"
      ports = ["80","22","443"]
      zone = "us-east1-b"
      subnet = "sub1"
      userdata_script = "script.sh"
    },
    "vm2" = {
      name = "vm2"
      image = "debian-cloud/debian-11"
      type = "custom-2-8192"
      ports = ["22"]
      zone = "us-east1-b"
      subnet = "sub1"
      userdata_script = "script.sh"
    }

  }
}

#Output of the vms public IPs
output "vm_ip_out" {
  value = module.my_vms.vm_ips   
}
```

In the above example, we are using the vms variable to define two VM configurations, vm1 and vm2, each with its respective properties.

Remember to customize the VM configurations according to your requirements.

## Outputs

<table>
  <tr>
    <th>Name</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>vm_ips</td>
    <td>The Public IP Adress of the created Virtual Machine.</td>
  </tr>
</table>