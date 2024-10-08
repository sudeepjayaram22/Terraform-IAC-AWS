variable "networking" {
  type = object({
    cidr_block      = string
    region          = string
    vpc_name        = string
    azs             = list(string)
    public_subnets  = list(string)
    private_subnets = list(string)
    nat_gateways    = bool
  })
  default = {
    cidr_block      = "141.0.0.0/16"
    region          = "us-east-1"
    vpc_name        = "terraform-vpc"
    azs             = ["us-east-1a", "us-east-1b"]
    public_subnets  = ["141.0.1.0/24", "141.0.2.0/24"]
    private_subnets = ["141.0.3.0/24", "141.0.4.0/24"]
    nat_gateways    = true
  }
}

variable "security_groups" {
  type = list(object({
    name        = string
    description = string
    ingress = list(object({
      description      = string
      protocol         = string
      from_port        = number
      to_port          = number
      cidr_blocks      = list(string)
      ipv6_cidr_blocks = list(string)
    }))
    egress = list(object({
      description      = string
      protocol         = string
      from_port        = number
      to_port          = number
      cidr_blocks      = list(string)
      ipv6_cidr_blocks = list(string)
    }))
  }))
  default = [{
    name        = "custom-security-group"
    description = "Inbound & Outbound traffic for custom-security-group"
    ingress = [
      {
        description      = "Allow HTTPS"
        protocol         = "tcp"
        from_port        = 443
        to_port          = 443
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = null
      },
      {
        description      = "Allow HTTP"
        protocol         = "tcp"
        from_port        = 80
        to_port          = 80
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = null
      },
    ]
    egress = [
      {
        description      = "Allow all outbound traffic"
        protocol         = "-1"
        from_port        = 0
        to_port          = 0
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
      }
    ]
  }]
}

variable "cluster_config" {
  type = object({
    name    = string
    version = string
  })
  default = {
    name    = "eks-cluster"
    version = "1.29"
  }
}

variable "node_groups" {
  type = list(object({
    name           = string
    instance_types = list(string)
    ami_type       = string
    capacity_type  = string
    disk_size      = number
    scaling_config = object({
      desired_size = number
      min_size     = number
      max_size     = number
    })
    update_config = object({
      max_unavailable = number
    })
  }))
  default = [
     {
      #name           = "t3-micro-standard"
      name           = "t2-micro-standard1"
      instance_types = ["t2.micro"]
      #instance_types = ["t3.micro"]
      ami_type       = "AL2_x86_64"
      capacity_type  = "ON_DEMAND"
      disk_size      = 20
      scaling_config = {
        desired_size = 1
        max_size     = 1
        min_size     = 1
      }
      update_config = {
        max_unavailable = 1
      }
    },
    {
      #name           = "t3-micro-standard"
      name           = "t2-micro-standard2"
      instance_types = ["t2.micro"]
      #instance_types = ["t3.micro"]
      ami_type       = "AL2_x86_64"
      capacity_type  = "ON_DEMAND"
      disk_size      = 20
      scaling_config = {
        desired_size = 1
        max_size     = 1
        min_size     = 1
      }
      update_config = {
        max_unavailable = 1
      }
    }
    #,
    #{
    #  name           = "t3-micro-spot"
    #  instance_types = ["t3.micro"]
    #  ami_type       = "AL2_x86_64"
    #  capacity_type  = "SPOT" #"ON_DEMAND" for dedicated purpose , SPOT can be taken away and given to someone else  
    #  disk_size      = 20
    #  scaling_config = {
    #    desired_size = 1
    #    max_size     = 1
    #    min_size     = 1
    #  }
    #  update_config = {
    #    max_unavailable = 1
    #  }
    #}
  ]
}

variable "addons" {
  type = list(object({
    name    = string
    version = string
  }))
  default = [
    {
      name    = "kube-proxy"
      version = "v1.29.1-eksbuild.2"
    }
    //,
    //{
    //  name    = "vpc-cni"
    //  version = "v1.18.0-eksbuild.1"
    //},
    //{
    //  name    = "coredns"
    //  version = "v1.11.1-eksbuild.6"
    //},
    //{
    //  name    = "aws-ebs-csi-driver"
    //  version = "v1.11.4-eksbuild.1"
    //  }
  ]
}

variable "public_subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
  default     = ["subnet-0068b3a4192bd1f7c",    "subnet-0d9594b7d0841f515"]
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
  default     = ["sg-0d6e9f1803fe5982b"]
}

variable "private_subnet_ids" {
  description = "List of private_subnet IDs"
  type        = list(string)
  default     = [  "subnet-06e9231507e2a04ce",    "subnet-0f9f963d467f06416"]
}
