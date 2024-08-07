


# State management for EKS
terraform {
   backend "s3" {
     bucket         = "my-state-management"
     key            = "LoadBalancerController/terraform.tfstate"
#     encrypt        = true
     region         = "us-east-1"
#     #dynamodb_table = "terraform-state-locks"
   }
}


data "aws_eks_cluster" "eld_cluster"{
  name = var.eks_cluster_name
}

# Helm Release for AWS Load Balancer Controller
resource "helm_release" "aws-load-balancer-controller" {
  # Name of the Helm release
  name       = var.helm_release_name

  # Helm chart repository information
  repository = var.helm_repository
  chart      = var.helm_chart
  namespace  = var.helm_namespace
  version    = var.helm_version

  # Helm set values for configuring the release
  set {
    name  = "clusterName"
    value = data.aws_eks_cluster.eld_cluster.id
  }

  set {
    name  = "image.tag"
    value = "v2.4.2"
  }

  set {
    name  = "replicaCount"
    value = 1
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.aws_load_balancer_controller.arn
  }

  # EKS Fargate specific settings
  set {
    name  = "region"
    value = "us-east-1"
  }

  set {
    name  = "vpcId"
    value = var.vpc_id
    # value = aws_vpc.eks_vpc.id
  }
}

# Datasource: EKS Cluster Auth
data "aws_eks_cluster_auth" "eld_cluster_auth" {
  name = var.eks_cluster_name
}
