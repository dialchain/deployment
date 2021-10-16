module "dial-relay" {
  source = "../../module/azure/aci"
  prefix = var.prefix
  container-name = var.container-name
  container-image = lower(var.container-image)
  environment_variables = var.environment_variables
  ports  = var.ports
  tags   = var.tags
}