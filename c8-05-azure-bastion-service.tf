resource "azurerm_subnet" "bastion_service_subnet" {
  name = var.bastion_service_subnet_name
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name =  azurerm_virtual_network.vnet.name
  address_prefixes = var.bastion_service_address_prefixes
}

resource "azurerm_public_ip" "bastion_service_publicip" {
  name = "${local.resource_name_prefix}-bastion-service-publicip"
  #computer_name = "weblinuxvm" #hostname of the vm(optional)
  resource_group_name = azurerm_resource_group.rg.name 
  location =  azurerm_resource_group.rg.location
  allocation_method = "Static"
  sku = "Standard"
}

resource "azurerm_bastion_host" "bastion_host" {
  name = "${local.resource_name_prefix}-bastion-service"
  #computer_name = "weblinuxvm" #hostname of the vm(optional)
  resource_group_name = azurerm_resource_group.rg.name 
  location =  azurerm_resource_group.rg.location
  ip_configuration {
    name = "configuration"
    subnet_id = azurerm_subnet.bastion_service_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_service_publicip.id
  }
}