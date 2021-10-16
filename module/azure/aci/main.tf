resource "azurerm_resource_group" "this" {
  name     = "${lower(var.prefix)}-resources"
  location = var.location
}

resource "azurerm_container_group" "this" {
  name                = "${lower(var.prefix)}-container"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  dns_name_label      = "${lower(var.prefix)}-aci-vnet"
  os_type             = "linux"
  ip_address_type     = "public"
  exposed_port = [
    {
      port = "9092"
      protocol = "TCP"
    }
  ]

  container {
    name   = var.container-name
    image  = var.container-image
    cpu    = "0.5"
    memory = "1.5"
    environment_variables = var.environment_variables

    ports {
      port     = var.ports.port
      protocol = var.ports.protocol
    }

    volume {
      name = "${lower(var.prefix)}-container"
      mount_path = "/home/"
      empty_dir = true
    }
  }

  tags = merge(local.default-tags, var.tags)

  depends_on = [azurerm_resource_group.this]
}