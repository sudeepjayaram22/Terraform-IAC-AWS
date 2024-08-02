# EKS Cluster Configuration
variable "eks_cluster_name" {
  type        = string
  description = "Name for the EKS cluster"
  default = "eks-cluster"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the existing VPC"
  default = "vpc-0f7d4e18a8076a061"
}

# Helm chart resource configuration
variable "helm_release_name" {
  description = "The name of the Helm release"
  type        = string
  default     = "aws-load-balancer-controller"
}

variable "helm_repository" {
  description = "The URL of the Helm chart repository"
  type        = string
  default     = "https://aws.github.io/eks-charts"
}

variable "helm_chart" {
  description = "The name of the Helm chart"
  type        = string
  default     = "aws-load-balancer-controller"
}

variable "helm_namespace" {
  description = "The namespace in which to deploy the Helm release"
  type        = string
  default     = "kube-system"
}

variable "helm_version" {
  description = "The version of the Helm chart"
  type        = string
  default     = "1.4.1"
}
