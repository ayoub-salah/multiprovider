provider "google" {
  credentials = file("creds.json")
  project     = "playground-s-11-96630053"
  region      = "europe-west1"
  zone        = "europe-west1-b"
}

#VPC module call
module "my_vpc" {
  source = "../modules/vpc/gcp"

  #inputs
  vpc_name = "new_test_vpc"
}

#output
output "vpc_name_out" {
  value = module.my_vpc.vpc_name
}