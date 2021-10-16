provider "aws" {
  region = var.region
}

module "dial-relay" {
  source = "..\/..\/..\/terraform-module\/aws\/ecs"
  prefix = var.prefix
  container-name = var.container-name
  container-image = lower(var.container-image)
  stage_name = var.stage_name
  //  environment = var.environment
  container-port  = var.container-port
  host-port = var.host-port
  region = var.region
}