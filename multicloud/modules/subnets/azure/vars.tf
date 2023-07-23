variable "subnets" {
  type    = map(object({
    cidr_block = list(string)
  }))
  default = {}
}

variable "vpc_name" {
  description = "Name of the VPC where subnets will be created"
  type        = string
}

variable "rg" {
  type        = string
}

/*
variable "vpc_id" {
  description = "ID of the VPC where subnets will be created"
  type        = string
}
*/