###################
# Namespace cert manager
###################
resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = "cert-manager"
    labels = {
      "app.kubernetes.io/name"       = "cert-manager"
      "app.kubernetes.io/component"  = "controller"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
}

###################
# Helm cert manager
###################
resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  chart      = "cert-manager"
  repository = "https://charts.jetstack.io"
  version    = "v1.3.1"
  namespace  = kubernetes_namespace.cert_manager.metadata[0].name

  set {
    name  = "webhook.securePort"
    value = "10260"
  }

  set {
    name  = "installCRDs"
    value = true
  }

  set {
    name  = "prometheus.enabled"
    value = false
  }

  set {
    name  = "serviceAccount.create"
    value = true
  }

  set {
    name  = "replicaCount"
    value = 1
  }
  depends_on = [module.aks_cluster]
}
