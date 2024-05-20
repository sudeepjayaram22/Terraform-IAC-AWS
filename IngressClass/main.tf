provider "kubernetes" {
  config_path = "~/.kube/config"  # Path to your kubeconfig file
}

resource "kubernetes_ingress" "alb_ingress" {
  metadata {
    name = "alb-ingress"
    namespace = "kube-system"  # Assuming AWS Load Balancer Controller is installed in kube-system namespace
    annotations = {
      "kubernetes.io/ingress.class" = "alb"
      "alb.ingress.kubernetes.io/scheme" = "internet-facing"
      "alb.ingress.kubernetes.io/target-type" = "ip"
      "alb.ingress.kubernetes.io/load-balancer-name" = "my-alb"  # Specify the name of your ALB here
      "alb.ingress.kubernetes.io/subnets" = "subnet-08433862b4e80518e,subnet-0c95b2767995fe105"  # Specify your subnet IDs here
      "alb.ingress.kubernetes.io/tags" = "Environment=production,Team=devops"  # Specify your tags here
    }
  }

  spec {
    rule {
      http {
        path {
          path = "/*"
          backend {
            service_name = "alb-ingress-controller"
            service_port = 80
          }
        }
      }
    }
  }
}
