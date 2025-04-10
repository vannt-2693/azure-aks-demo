##################
# Namespace External secrets
###################
resource "kubernetes_namespace" "external_secrets" {
  metadata {
    name = "external-secrets"
    labels = {
      "app.kubernetes.io/name"       = "external-secrets"
      "app.kubernetes.io/component"  = "controller"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
}

###################
# Helm chart external secrets
###################
resource "helm_release" "external_secrets" {
  name       = "external-secrets"
  chart      = "external-secrets"
  repository = "https://charts.external-secrets.io"
  version    = "v0.9.4"
  namespace  = kubernetes_namespace.external_secrets.metadata[0].name

  set {
    name  = "webhook.port"
    value = "9443"
  }

  set {
    name  = "installCRDs"
    value = true
  }

  set {
    name  = "serviceAccount.create"
    value = true
  }

  set {
    name  = "replicaCount"
    value = 2
  }
  depends_on = [module.aks_cluster]
}
