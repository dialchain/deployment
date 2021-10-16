resource "azurerm_resource_group" "this" {
  name     = "${local.name}-resources"
  location = var.location
}

resource "azurerm_storage_account" "this" {
  name                      = "${lower(var.prefix)}${random_pet.name.id}"
  resource_group_name       = azurerm_resource_group.this.name
  location                  = azurerm_resource_group.this.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true
}

resource "azurerm_storage_share" "aci_caddy" {
  name                 = "${local.name}-caddy-data"
  storage_account_name = azurerm_storage_account.this.name
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
      port     = "9092"
      protocol = "TCP"
    }
  ]

  container {
    name                  = var.container-name
    image                 = var.container-image
    cpu                   = "0.5"
    memory                = "1.5"
    environment_variables = var.environment_variables

    ports {
      port     = var.ports.port
      protocol = var.ports.protocol
    }
  }

  container {
    name   = "caddy"
    image  = "caddy"
    cpu    = "0.5"
    memory = "0.5"

    ports {
      port     = 443
      protocol = "TCP"
    }

    ports {
      port     = 80
      protocol = "TCP"
    }

    volume {
      name                 = "${lower(var.prefix)}-caddy-data"
      mount_path           = "/data"
      storage_account_name = azurerm_storage_account.this.name
      storage_account_key  = azurerm_storage_account.this.primary_access_key
      share_name           = azurerm_storage_share.aci_caddy.name
    }

    commands = ["caddy", "reverse-proxy", "--from", "${lower(var.prefix)}-aci-vnet.${lower(var.tld)}", "--to", "localhost:${var.ports.port}"]
  }

  tags = merge(local.default-tags, var.tags)

  depends_on = [azurerm_resource_group.this]
}