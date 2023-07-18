variable "instances" {
  description = "Map of instances to create"
  type = map(object({
    ami           = string
    instance_type = string
    subnet_id     = string
  }))
  default = {}
}
