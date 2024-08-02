variable "swagger_file_path" {
  description = "File path for the Swagger JSON file"
  type        = string
  default     = "./swagger/dev/random.json"  
}

variable "vpc_cidr_block" {
  description = "CIDR block for the main VPC"
  type        = string
  default     = "10.0.0.0/16"  
}

variable "vpc_link_uri" {
  description = "URI for the VPC Link"
  type        = string
  default     = ""  
}

variable "path_parameters" {
  description = "List of path parameters"
  type        = list(string)
  default     = []
}

variable "query_parameters" {
  description = "Map of query parameters"
  type        = map(string)
  default     = {}
}

variable "stage_name" {
  description = "Name of the Staging Environment"
  type        = string
  default     = "dev"
}

variable "create_stage" {
  default = true
}

variable "vpc_url" {
  type=string
  default=""
}

variable "endpoint"{
  type = string
  default="/api/randomapi"
}

variable "waf_arn"{
  description = "ARN of the WAF"
  default=""
}

#domain name variables

variable "domain_name" {
  description = "Domain name of the API gateway"
  type = string
  default = "xyz.com"
}

variable "certificate_arn_no" {
  description = "ARN of the certificate issued"
  type = string
  default = "arn"
}

variable "security_policy_value" {
  description = "Transport Layer Security (TLS). Valid values are TLS_1_0 and TLS_1_2"
  type = string
  default = "TLS_1_2"
}

#VPC link Details 
variable "vpc_link_name" {
  description = "VPC link Name for the environment for enabling communication between an API Gateway and NLB."
  type = string
  default = "vpclink-nlb"
}

#Load balancer details

variable "load_balancer_arn" {
  description = "ARN of the load balancer for the respective environment"
  type = string
  default = "arn:aws:elasticloadbalancing:us-east-1:ghvgjbub/uyguy/uyuy"
}

variable "load_balancer_name" {
  description = "Name of the load balancer for the respective environment"
  type = string
  default = "my-nlb"
}