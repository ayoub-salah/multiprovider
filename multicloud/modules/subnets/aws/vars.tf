variable "subnets" {
  description = "Map of subnets to create"
  type        = map(object({
    cidr_block        = string
    availability_zone = string
    map_public_ip     = bool
  }))
  default = {}
}

variable "vpc_id" {
  description = "ID of the VPC where subnets will be created"
  type        = string
}
