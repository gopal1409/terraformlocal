output "virtual_network_name" {
  description = "Virtual Network Name"
  value = azurerm_virtual_network.vnet.name
}

output "virtual_network_id" {
  description = "Virtual Network ID"
  value = azurerm_virtual_network.vnet.id
}
output "web_subnet_name" {
  description = "Websubnet Name"
  value = azurerm_subnet.websubnet.name
}
output "web_subnet_id" {
  description = "Websubnet id"
  value = azurerm_subnet.websubnet.id
}
output "web_subnet_nsg_name" {
  description = "Web Subnet nsg Name"
  value = azurerm_network_security_group.web_subnet_nsg.name
}
