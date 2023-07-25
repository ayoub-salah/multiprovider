//***********************************************************VARS FOR AWS
variable "vpcs_aws" {
  description = "Configuration des VPC"
  type        = map(object({
    address_space = list(string)
    location      = string
  }))
  default = {}
}
/*
variable "vpc_id" {
  description = "VPC ID to create subnets in"
  type        = string
  default     = "vpc1"
}
*/

variable "subnets_aws" {
  description = "Map of subnets to create"
  type        = map(object({
    cidr_block        = list(string)
    map_public_ip     = bool
    availability_zone = string
    vpc_name = string
  }))
  default = {}
}

variable "instances_aws" {
  description = "Une carte des instances EC2 à créer"
  type        = map(object({ 
    ami = string, 
    instance_type = string, 
    subnet_name = string 
  }))
  default = {}
}

//***********************************************************VARS FOR AZURE 
variable "rg" {
  description = "rg where subnets are deployed "
  type        = string
  default     = "1-93985c2a-playground-sandbox"
}