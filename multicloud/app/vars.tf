variable "deploy_aws" {
  description = "Déployer les ressources sur AWS"
  type        = bool
  default     = true
}

variable "deploy_azure" {
  description = "Déployer les ressources sur Azure"
  type        = bool
  default     = false
}

/*
variable "rg" {
  description = "Nom du groupe de ressources Azure"
  type        = string
  default     = "my-resource-group"
}
*/

variable "vpcs" {
  description = "Configuration des VPC"
  type        = map(object({
    address_space = list(string)
    location      = string
    resource_group    = string
  }))
  default = {
    vpc1 = {
      address_space = ["192.168.1.0/24"]
      location      = "East US"
      resource_group = "my-resource-group"

    }
    vpc2 = {
      address_space = ["192.168.2.0/24"]
      location      = "East US"
      resource_group = "my-resource-group"
    }
    vpc3 = {
      address_space = ["192.168.3.0/24"]
      location      = "East US"
      resource_group = "my-resource-group"
    }
  }
}

variable "vpc_id" {
  description = "VPC ID to create subnets in"
  type        = string
  default     = "vpc1"
}

variable "internet_gateway_id" {
  description = "Internet gateway ID for the subnets"
  type        = string
}

variable "subnets" {
  description = "Map of subnets to create"
  type        = map(object({
    cidr_block        = string
    map_public_ip     = bool
    availability_zone = string
  }))
  default = {
    public_subnet_1  = { cidr_block = "192.168.1.0/26", availability_zone = "us-east-1a", map_public_ip = true },
    public_subnet_2  = { cidr_block = "192.168.1.64/26", availability_zone = "us-east-1b", map_public_ip = true },
  }
}
