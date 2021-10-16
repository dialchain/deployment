module "dial-relay" {
  source = "../../../module/gcloud/c-run"
  container-name = var.container-name
  container-image = lower(var.container-image)
  environment_variables = var.environment_variables
  ports  = var.ports
}