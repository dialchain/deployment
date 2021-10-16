module "dial-relay" {
  source = "git::https://github.com/dialchain/deployment/tree/main/module/azure/aci-ssl"
  prefix = var.prefix
  container-name = var.container-name
  container-image = lower(var.container-image)
  environment_variables = var.environment_variables
  ports  = var.ports
  tags   = var.tags
}