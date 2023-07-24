variable "subnets" {
  type    = map(object({
      name             = string
      address_prefixes = list(string)
      resource_group   = string
  }))
  default = {}
}
variable "vpc_name" {
  type        = string
}
  
