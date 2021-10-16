variable "region" {
  default = "us-central1"
}

variable "project_id" {
  default = "ploohid"
  description = "The ID of the project where this VPC will be created"
}

variable "container-name" {
  default = "dial-relay"
}

variable "container-image" {
  description = "Container image"
  default     = "eu.gcr.io/ploohid/dial-relay:latest"
}

variable "ports" {
  description = "container ports configuration"
  type        = map(any)
  default     = {
    port      = "9092"
    protocol  = "TCP"
  }
}

variable "environment_variables" {
  description = "Container environment variables"
  type        = map(any)
  default     = {
    APP_PORT  = "9092"
  }
}