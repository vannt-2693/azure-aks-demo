# ###################
# # Create identity deploy service principal with password
# ###################
# module "aks_deploy_sp" {
#   source = "git@github.com:framgia/sun-infra-iac.git//modules/service-principal?ref=terraform-azure-service-principal_v0.0.1"

#   #basic
#   env     = var.env
#   project = var.project

#   #app
#   application = {
#     name     = "aks-sp"
#     owners   = [data.azuread_client_config.current.object_id]
#     password = {}
#   }

#   #sp
#   service_principal = {
#     owners = [data.azuread_client_config.current.object_id]
#   }
# }
