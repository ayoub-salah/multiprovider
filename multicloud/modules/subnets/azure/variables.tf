variable "rg" {
  type    = string
}
variable "subnets" {
  type    = map(object({
      name             = string
      address_prefixes = list(string)
  }))
  default = {}
}
variable "vpc_name" {
  type        = string
}
  
