variable "subnets_aws" {
  description = "Map of subnets to create"
  type        = map(object({
    cidr_block        = list(string)
    availability_zone = string
    map_public_ip     = bool
    vpc_name          = string
  }))
  default = {}
}


variable "internet_gateway_id" {
  description = "The ID of the internet gateways"
  type        = string
  default     = null
}

variable "vpc_ids" {
    description = "The IDs of the vpcs"
    type = map(string)
    default = {}
}
