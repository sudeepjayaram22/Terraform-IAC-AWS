terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.30.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
}

#provider "helm" {
#  kubernetes {
#    config_path = "C:/Users/sjayaram/.kube/config"
#  }
#}

# HELM Provider
provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.eld_cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eld_cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eld_cluster_auth.token
  }
}