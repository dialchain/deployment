resource "random_pet" "name" {
  length    = 3
  prefix    = "aci"
  separator = "-"
}

locals {
  name         = "${lower(var.prefix)}-${random_pet.name.id}"
  default-tags = merge(
    { "terraform.io" = "managed" },
    { "Name" = local.name },
  )
}
