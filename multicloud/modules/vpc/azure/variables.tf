# variable "rg" {
#   type    = string
# }
variable "vpcs" {
    type            = map(object({
    name            = string
    address_space   = list(string)
    location        = string
    resource_group  = string
   }))
}
# variable "nics" {
#   type = map(object({
#     subnet_id                     = string
#     private_ip_address_allocation = string
#   }))
#   default = {}
# }
