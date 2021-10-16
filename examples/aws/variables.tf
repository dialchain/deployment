variable "region" {
  default = "us-east-1"
}
variable "prefix" {
  default = "example"
}

variable "stage_name" {
  default = "demo"
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
  type = list(any)
  default = [
    {
      name = "APP_PORT",
      value = "9092"
    }
  ]
}