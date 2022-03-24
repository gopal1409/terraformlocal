output "web_linuxvm_network_interface_id" {
  value = azurerm_network_interface.web_linuxvm_nic[*].id
}
