#
output "ip_address" {
  value = azurerm_container_group.this.ip_address
}

#the dns fqdn of the container group if dns_name_label is set
output "fqdn" {
  value = "https://${azurerm_container_group.this.fqdn}"
}