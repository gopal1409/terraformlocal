/*#webtier subnet
#nsg
#when we create nsg we need to open ports
resource "azurerm_subnet" "websubnet" {
  name                 = "${azurerm_virtual_network.vnet.name}-${var.web_subnet_name}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.web_subnet_address
}

#now i will create a nsg
resource "azurerm_network_security_group" "web_subnet_nsg" {
  name                = "${azurerm_subnet.websubnet.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
#assocaite the nsg with subnet

resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg_associate" {
    #every nsg rule assocaite will be disassocaite from the subnet and asoosciate
    #once your nsg is completely create then only this inbound rule will be added. 
  depends_on = [azurerm_network_security_rule.web_nsg_rule_inbound] 
  subnet_id                 = azurerm_subnet.websubnet.id
  network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id
}

locals {
  web_inbound_ports_maps = {
    "110" : "80", #if your key and value is string you have to use = if your key and value is numeric :
    "120" : "443",
    "130" : "22"
  }
}

resource "azurerm_network_security_rule" "web_nsg_rule_inbound" {
  for_each                    = local.web_inbound_ports_maps
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.web_subnet_nsg.name
}*/