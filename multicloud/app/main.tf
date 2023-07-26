#VPC module call
module "my_vpc" {
  source = "../modules/vpc/gcp"

  #Vpcs Input
  vpcs = {
    "vpc1" = {
      name   = "vpc1"    
    },
    "vpc2" = {
      name   = "vpc2"
    },
    "vpc3" = {
      name   = "vpc3"
    }
  }

}


#Subnet module call
module "my_subnet" {
  source = "../modules/subnets/gcp"
  depends_on = [module.my_vpc]    #this module starts after vpc module finishes executing 
  
  #Subnets Input
  subnets = {
    "subnet1" = {
      name = "sub1"
      ip_cidr_range = "10.169.0.0/20"
      region = "us-east1"
      vpc_name = "vpc2"
    },
    "subnet2" = {
      name = "sub2"
      ip_cidr_range = "10.167.0.0/20"
      region = "us-east1"
      vpc_name = "vpc1"
    }
  }
}


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