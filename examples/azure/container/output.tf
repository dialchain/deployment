#
output "ip_address" {
  value = module.dial-relay.ip_address
}

#the dns fqdn of the container group if dns_name_label is set
output "fqdn" {
  value = module.dial-relay.fqdn
}