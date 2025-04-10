###################
# Namespace for demo app
###################
resource "kubernetes_namespace" "ns_app" {
  metadata {
    name = "app"
    labels = {
      "app.kubernetes.io/name"       = "app"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }

  depends_on = [module.aks_cluster]
}

###################
# Install helm chart for demo app
###################
resource "helm_release" "local_app" {
  depends_on = [
    helm_release.external_secrets,
    helm_release.nginx_ingress
  ]
  name      = "aks-demo"
  chart     = "../../../../../k8s/Charts/app "
  namespace = kubernetes_namespace.ns_app.metadata[0].name

  timeout = 300

  lifecycle {
    ignore_changes = all
  }
}
