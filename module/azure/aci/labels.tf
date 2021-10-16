locals {
  name = lower(var.prefix)
  default-tags = merge(
    { "terraform.io" = "managed" },
    { "Name" = local.name },
  )
}
