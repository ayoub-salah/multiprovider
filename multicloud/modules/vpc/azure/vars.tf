variable "vpcs" {
    type            = map(object({
    address_space   = list(string)
    resource_group = string
    location        = string
   }))
}