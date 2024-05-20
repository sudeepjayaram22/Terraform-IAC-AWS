# VPC link name
variable "vpc_link_name" {
  type        = string
  description = "Name of the VPC link"
}

# VPC link name
variable "vpc_link_description" {
  type        = string
  description = "Description for the VPC link"
  default     = "VPC link for the NLB"
}

# NLB Name
variable "nlb_name" {
  type        = string
  description = "Name of the Network Load Balancer"
}

# VPC ID
#variable "vpc_id" {
#  type        = string
#  description = "The ID of the existing VPC"
#}

variable "env" {
  description = "Name of the Environment"
  type        = string
  default     = ""
}

# Tags for myapp resources
variable "new_tags" {
  type        = map(string)
  description = "Tags to be applied to the Network Load Balancer"
  default     = {
    Billing = "IndiaEngineering"
  }
}
