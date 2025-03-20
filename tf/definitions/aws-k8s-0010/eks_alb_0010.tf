# SPDX-FileCopyrightText: 2025-present Stuart Ellis <stuart@stuartellis.name>
#
# SPDX-License-Identifier: MIT
#

resource "kubernetes_ingress_v1" "ingress_alb" {
  metadata {
    name      = "${local.alb_name_prefix}-ingress"
    namespace = "default"
    annotations = {

      # Public ALB
      "alb.ingress.kubernetes.io/scheme" = "internet-facing"

      # AWS resource tags for ALBs
      "alb.ingress.kubernetes.io/tags" = "Environment=${var.environment_name},Product=${var.product_name},Provisioner=Terraform,Stack=${var.stack_name},Variant=${var.variant}"
    }
  }

  spec {
    # this matches the name of IngressClass.
    # this can be omitted if you have a default ingressClass in cluster: the one with ingressclass.kubernetes.io/is-default-class: "true"  annotation
    ingress_class_name = "${local.alb_name_prefix}-ingressclass-alb"

    rule {
      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service_v1.service_alb.metadata[0].name
              port {
                number = 8080
              }
            }
          }
        }
      }
    }
  }
}

# Kubernetes Service for the App
resource "kubernetes_service_v1" "service_alb" {
  metadata {
    name      = "${local.alb_name_prefix}-service-alb"
    namespace = "default"
    labels = {
      app = local.app_name
    }
  }

  spec {
    selector = {
      app = local.app_name
    }

    port {
      port        = 8080
      target_port = 8080
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_ingress_class_v1" "ingressclass_alb" {
  depends_on = [kubernetes_manifest.ingress_class_params]
  metadata {
    name = "${local.alb_name_prefix}-ingressclass-alb"

    annotations = {
      "ingressclass.kubernetes.io/is-default-class" = "true"
    }
  }

  spec {
    controller = "eks.amazonaws.com/alb"
    parameters {
      api_group = "eks.amazonaws.com"
      kind      = "IngressClassParams"
      name      = "${local.alb_name_prefix}-ingressclassparams-alb"
    }
  }
}

resource "kubernetes_manifest" "ingress_class_params" {
  manifest = {
    "apiVersion" = "eks.amazonaws.com/v1"
    "kind"       = "IngressClassParams"
    "metadata" = {
      "name" = "${local.alb_name_prefix}-ingressclassparams-alb"
    }
    "spec" = {
      "scheme" = "internet-facing"
    }
  }
}
