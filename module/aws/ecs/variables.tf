variable "region" {
  default = "us-east-1"
}
variable "prefix" {
  default = "monwallet"
}

variable "stage_name" {
  default = "dev"
}

variable "container-image" {
  description = "Container image"
  default     = "public.ecr.aws/s6b0c4h3/dial-relay:latest"
}

variable "container-name" {
  default = "dial-relay"
}

variable "container-port" {
  default = "9092"
}
variable "host-port" {
  default = "9092"
}

variable "environment" {
  type    = list(any)
  default = []
}