terraform {
  backend "s3" {
    bucket         = "my-state-management"
    key            = "eks-cluster/terraform.tfstate"
    region         = "us-east-1"
    #dynamodb_table = "terraform-lock-table"
    #encrypt        = true
  }
}

resource "aws_launch_template" "eks_launch_template" {
  name          = "eks-node-launch-template"
  instance_type = "t2.micro"
  key_name      = var.key_name  # Ensure this matches your key pair name

  user_data = base64encode(<<-EOF
    MIME-Version: 1.0
    Content-Type: multipart/mixed; boundary="====boundary===="

    --====boundary====
    Content-Type: text/x-shellscript; charset="us-ascii"

    #!/bin/bash
    echo "Installing SSM agent..."
    if command -v yum >/dev/null 2>&1; then
      yum install -y amazon-ssm-agent
      systemctl enable amazon-ssm-agent
      systemctl start amazon-ssm-agent
    elif command -v apt-get >/dev/null 2>&1; then
      apt-get update
      apt-get install -y amazon-ssm-agent
      systemctl enable amazon-ssm-agent
      systemctl start amazon-ssm-agent
    else
      echo "Unsupported Linux distribution."
      exit 1
    fi

    --====boundary====--
  EOF
  )

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size           = 20
      volume_type           = "gp2"
      delete_on_termination = true
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "eks-node"
    }
  }
}




# EKS Cluster
resource "aws_eks_cluster" "eks-cluster" {
  name     = var.cluster_config.name
  role_arn = aws_iam_role.EKSClusterRole.arn
  version  = var.cluster_config.version

  vpc_config {
    #subnet_ids         = flatten([module.aws_vpc.public_subnets_id, module.aws_vpc.private_subnets_id])
    subnet_ids         = var.subnet_ids
    #security_group_ids = flatten(module.aws_vpc.security_groups_id)
    security_group_ids = var.security_group_ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy
  ]

}

resource "aws_eks_node_group" "node-ec2" {
  for_each        = { for node_group in var.node_groups : node_group.name => node_group }
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = each.value.name
  node_role_arn   = aws_iam_role.NodeGroupRole.arn
  subnet_ids      = var.private_subnets_id

  scaling_config {
    desired_size = try(each.value.scaling_config.desired_size, 1)
    max_size     = try(each.value.scaling_config.max_size, 1)
    min_size     = try(each.value.scaling_config.min_size, 1)
  }

  update_config {
    max_unavailable = try(each.value.update_config.max_unavailable, 1)
  }

  ami_type       = "AL2_x86_64"  # Use a default type for standard AMIs
  capacity_type  = each.value.capacity_type

  launch_template {
    name    = aws_launch_template.eks_launch_template.name
    version = "$Latest"
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonSSMManagedInstanceCore
  ]
}



# Fetch EKS optimized AMI for your region
data "aws_ami" "eks_worker" {
  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI owner ID
  filter {
    name   = "name"
    values = ["amazon-eks-node-1.29-v*"]
  }
}

# Variables for the key name
variable "key_name" {
  description = "The name of the key pair to use for SSH access to the instances"
  type        = string
  default     = "sudeep-ec2-keypair"
}
