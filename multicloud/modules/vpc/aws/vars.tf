variable "vpcs" {
  description = "Map of vpc's to create"
  type        = map(object({
    cidr_block        = string
  }))
  default = {}
}

/*
variable "vpc_cidr" {
  description = "CIDR for VPC"
  type        = string
}

variable "tags" {
  description = "tags to assign to the resources"
  type        =  string
}
*/