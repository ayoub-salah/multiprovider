variable "name" {
  description = "The base name to use for the NAT Gateway and EIP"
  type        = string
}

variable "public_subnet_id" {
  description = "The ID of the subnet in which to place the NAT Gateway"
  type        = string
}
