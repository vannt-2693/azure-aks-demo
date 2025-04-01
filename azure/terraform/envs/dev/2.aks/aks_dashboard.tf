# ###################
# # Namespace for kubernetes dashboard
# ###################
# resource "kubernetes_namespace" "ns_kubernetes_dashboard" {
#   metadata {
#     name = "kubernetes-dashboard"
#     labels = {
#       "app.kubernetes.io/name"       = "kubernetes-dashboard"
#       "app.kubernetes.io/managed-by" = "terraform"
#     }
#   }

#   depends_on = [module.aks_cluster]
# }

# # resource "helm_release" "kubernetes_dashboard" {
# #   depends_on = [
# #     module.aks_cluster,
# #     kubernetes_namespace.ns_kubernetes_dashboard,
# #     kubernetes_secret_v1.dashboard_tls_secret
# #   ]

# #   name       = "kubernetes-dashboard"
# #   repository = "https://kubernetes.github.io/dashboard/"
# #   chart      = "kubernetes-dashboard"
# #   namespace  = "kubernetes-dashboard"
# #   version    = "7.11.1"

# #   set {
# #     name  = "protocolHttp"
# #     value = "true"
# #   }
# #   set {
# #     name  = "serviceAccount.create"
# #     value = "true"
# #   }
# #   set {
# #     name  = "serviceAccount.name"
# #     value = "admin-user"
# #   }
# #   set {
# #      name = "rbac.clusterAdminRole"
# #      value = "true"
# #   }

# #   values = [
# #     file("${path.module}/dashboard-values.yaml")
# #   ]
# # }

# resource "kubernetes_secret_v1" "dashboard_tls_secret" {

#   metadata {
#     name      = "dashboard-tls-secret"
#     namespace = "kubernetes-dashboard"
#   }

#   data = {
#     "tls.crt" = filebase64("../../../../../k8s/Charts/dashboard/vaan.eragon123app.com.crt")
#     "tls.key" = filebase64("../../../../../k8s/Charts/dashboard/vaan.eragon123app.com.key")
#   }

#   type = "kubernetes.io/tls"
# }

# # resource "kubernetes_ingress_v1" "dashboard_ingress" {
# #   depends_on = [helm_release.kubernetes_dashboard, kubernetes_secret_v1.dashboard_tls_secret]

# #   metadata {
# #     name      = "kubernetes-dashboard-ingress"
# #     namespace = "kubernetes-dashboard"
# #     annotations = {
# #       "kubernetes.io/ingress.class" = "nginx"
# #       "nginx.org/ssl-services": "kubernetes-dashboard-service"
# #       "nginx.ingress.kubernetes.io/rewrite-target": "/"
# #       "nginx.ingress.kubernetes.io/backend-protocol": "HTTPs"
# #       # "nginx.ingress.kubernetes.io/ssl-passthrough": "true"
# #       # "nginx.ingress.kubernetes.io/ssl-redirect": "true"
# #       # "appgw.ingress.kubernetes.io/backend-protocol" = "https"
# #       # "appgw.ingress.kubernetes.io/ssl-redirect" = "true"
# #     }
# #   }

# #   spec {

# #     tls {
# #       hosts = ["dashboard.vaan.eragon123app.com"]
# #       secret_name = kubernetes_secret_v1.dashboard_tls_secret.metadata[0].name
# #     }
# #     rule {
# #       host = "dashboard.vaan.eragon123app.com"
# #       http {
# #         path {
# #           path = "/"
# #           path_type = "Prefix"

# #           backend {
# #             service {
# #               name = "kubernetes-dashboard-web" #helm_release.kubernetes_dashboard.name
# #               port {
# #                 # Port mà service của Dashboard expose (thường là 443 cho HTTPS)
# #                 # Kiểm tra lại service bằng kubectl get svc -n kubernetes-dashboard nếu không chắc
# #                 number = 8000
# #               }
# #             }
# #           }
# #         }
# #       }
# #     }
# #   }
# # }
