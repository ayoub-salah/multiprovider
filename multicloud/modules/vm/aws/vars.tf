variable "instances_aws" {
  description = "Map of instances to create"
  type = map(object({
    ami           = string
    instance_type = string
    subnet_name     = string
  }))
  default = {}
}

  variable "subnet_ids" {
    description = "The IDs of the subnets"
    type = map(string)
    
    default = {}
  }