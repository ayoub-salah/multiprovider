variable "vpcs" {
  description = "Map of vpc's to create"
  type        = map(object({
    address_space        = list(string)
  }))
  default = {}
}