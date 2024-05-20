# Retrieve the TLS certificate from the EKS cluster for OIDC configuration
data "tls_certificate" "eks_tls_cert" {
  url = data.aws_eks_cluster.eld_cluster.identity[0].oidc[0].issuer
}

# Create an OpenID Connect provider for EKS cluster
resource "aws_iam_openid_connect_provider" "eks_oicp" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks_tls_cert.certificates[0].sha1_fingerprint]
  url             = data.aws_eks_cluster.eld_cluster.identity[0].oidc[0].issuer
}

# Define the IAM policy document for assuming roles with Web Identity
data "aws_iam_policy_document" "aws_load_balancer_controller_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks_oicp.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-load-balancer-controller"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks_oicp.arn]
      type        = "Federated"
    }
  }
}

# Create an IAM role for the AWS Load Balancer Controller
resource "aws_iam_role" "aws_load_balancer_controller" {
  assume_role_policy = data.aws_iam_policy_document.aws_load_balancer_controller_assume_role_policy.json
  name               = "aws-load-balancer-controller"
}

# Attach the policy from a file to the AWS Load Balancer Controller IAM role
resource "aws_iam_policy" "aws_load_balancer_controller" {
  policy = file("./AWSLoadBalancerController.json")
  name   = "AWSLoadBalancerController"
}

# Attach the policy to the IAM role
resource "aws_iam_role_policy_attachment" "aws_load_balancer_controller_attach" {
  role       = aws_iam_role.aws_load_balancer_controller.name
  policy_arn = aws_iam_policy.aws_load_balancer_controller.arn
}
