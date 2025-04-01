resource "azurerm_public_ip" "agw_ip" {
  allocation_method   = "Static"
  location            = var.location
  name                = "aks-appgw-ip"
  resource_group_name = data.terraform_remote_state.general.outputs.resource_group_name
  sku                 = "Standard"
}

resource "azurerm_application_gateway" "agw" {
  name                = "aks-ingress"
  location            = var.location
  resource_group_name = data.terraform_remote_state.general.outputs.resource_group_name

  backend_address_pool {
    name = "appgw-backend-pool"
  }
  backend_http_settings {
    cookie_based_affinity = "Disabled"
    name                  = "appgw-backend-be-htst"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
  }
  frontend_ip_configuration {
    name                 = "appgw-backend-feip"
    public_ip_address_id = azurerm_public_ip.agw_ip.id
  }
  frontend_port {
    name = "appgw-backend-feport"
    port = 80
  }
  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = data.terraform_remote_state.general.outputs.subnet_agw_id
  }
  http_listener {
    frontend_ip_configuration_name = "appgw-backend-feip"
    frontend_port_name             = "appgw-backend-feport"
    name                           = "appgw-backend-httplstn"
    protocol                       = "Http"
  }
  request_routing_rule {
    http_listener_name         = "appgw-backend-httplstn"
    name                       = "appgw-backend-rqrt"
    rule_type                  = "Basic"
    backend_address_pool_name  = "appgw-backend-pool"
    backend_http_settings_name = "appgw-backend-be-htst"
    priority                   = 1
  }
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }

  lifecycle {
    ignore_changes = [
      tags,
      backend_address_pool,
      backend_http_settings,
      http_listener,
      probe,
      request_routing_rule,
      url_path_map,
      frontend_port,
      redirect_configuration,
      ssl_certificate
    ]
  }
}

resource "helm_release" "nginx_ingress" {
  depends_on = [module.aks_cluster]

  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "ingress-nginx"

  create_namespace = true

  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "controller.ingressClass"
    value = "nginx"
  }

  set {
    name  = "controller.publishService.enabled"
    value = "true"
  }
}

# resource "kubernetes_secret_v1" "agic_tls_secret" {

#   metadata {
#     name      = "agic-tls-secret"
#     namespace = "ingress-nginx"
#   }

#   data = {
#     "tls.crt" = filebase64("../../../../../k8s/Charts/dashboard/vaan.eragon123app.com.crt")
#     "tls.key" = filebase64("../../../../../k8s/Charts/dashboard/vaan.eragon123app.com.key")
#   }

#   type = "kubernetes.io/tls"
# }

resource "kubernetes_ingress_v1" "agic_to_nginx" {
  depends_on = [
    helm_release.nginx_ingress,
    # kubernetes_secret_v1.agic_tls_secret
  ]

  metadata {
    name      = "agic-to-nginx-ingress"
    namespace = "ingress-nginx"
    annotations = {
      "kubernetes.io/ingress.class" : "azure/application-gateway"
      "appgw.ingress.kubernetes.io/backend-protocol" : "http"
      "appgw.ingress.kubernetes.io/health-probe-path" : "/healthz"
      "appgw.ingress.kubernetes.io/health-probe-port" : "10254"
      "appgw.ingress.kubernetes.io/health-probe-protocol" : "http"
    }
  }
  spec {
    # tls {
    #   hosts = ["*.vaan.eragon123app.com"]
    #   secret_name = "agic-tls-secret"
    # }
    rule {
      host = "*.vaan.eragon123app.com"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "nginx-ingress-ingress-nginx-controller"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}
