###################
# Namespace for demo app
###################
resource "kubernetes_namespace" "demo_example" {
  metadata {
    name = "demo"
    labels = {
      "app.kubernetes.io/name"       = "demo"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }

  depends_on = [module.aks_cluster]
}

resource "kubernetes_pod" "demo_aspnet_app" {
  metadata {
    labels = {
      "app"                          = "demo-aspnetapp"
      "app.kubernetes.io/name"       = "demo-aspnetapp"
      "app.kubernetes.io/managed-by" = "terraform"
    }
    name      = "demo-aspnetapp"
    namespace = kubernetes_namespace.demo_example.metadata[0].name
  }
  spec {
    container {
      name              = "aspnetapp-image"
      image             = "mcr.microsoft.com/dotnet/samples@sha256:7070894cc10d2b1e68e72057cca22040c5984cfae2ec3e079e34cf0a4da7fcea"
      image_pull_policy = "Always"

      port {
        container_port = 80
        protocol       = "TCP"
      }
      resources {
        limits = {
          cpu    = "250m"
          memory = "256Mi"
        }
        requests = {
          cpu    = "250m"
          memory = "256Mi"
        }
      }
      security_context {}
    }
  }
}

resource "kubernetes_service" "demo_svc" {
  metadata {
    name      = "demo-svc-aspnetapp"
    namespace = kubernetes_namespace.demo_example.metadata[0].name
    labels = {
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
  spec {
    selector = {
      app = kubernetes_pod.demo_aspnet_app.metadata[0].name
    }

    port {
      port        = 80
      target_port = 80
      protocol    = "TCP"
    }
  }
}

resource "kubernetes_ingress_v1" "demo_ing" {
  metadata {
    name      = "demo-ingress-aspnetapp"
    namespace = kubernetes_namespace.demo_example.metadata[0].name
    annotations = {
      "kubernetes.io/ingress.class" : "nginx"
    }
    labels = {
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = "aks.vaan.eragon123app.com"
      http {
        path {
          path      = "/"
          path_type = "Exact"

          backend {
            service {
              name = kubernetes_service.demo_svc.metadata[0].name

              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }

  depends_on = [
    module.aks_cluster,
  ]
}
