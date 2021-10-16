variable "prefix" {
  description = "The Prefix used for all resources in this example"
  default     = "monwallet"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default     = "West Europe"
}

variable "container-name" {
  default = "dial-relay"
}

variable "container-image" {
  description = "Container image"
  default = "public.ecr.aws/s6b0c4h3/dial-relay:latest"
}

variable "environment_variables" {
  description = "Container environment variables"
  type        = map(any)
  default     = {
    APP_PORT  = "9092"
  }
}

variable "ports" {
  description = "container ports configuration"
  type        = map(any)
  default     = {
    port      = "80"
    protocol  = "TCP"
  }
}

### tags
variable "tags" {
  description = "The key-value maps for tagging"
  type        = map(string)
  default     = {}
}