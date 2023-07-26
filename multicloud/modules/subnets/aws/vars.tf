variable "subnets" {
}

variable "vpc_ids" {
}

variable "internet_gateway_id" {
  description = "The ID of the internet gateways"
  type        = string
  default     = null
}