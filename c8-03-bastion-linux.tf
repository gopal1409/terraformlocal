/*#create an public ip
resource "azurerm_public_ip" "bastion_linuxvm_publicip" {
  name = "${local.resource_name_prefix}-bastion-linuxvm-publicip"
  resource_group_name = azurerm_resource_group.rg.name 
  location =  azurerm_resource_group.rg.location
  allocation_method = "Static"
  sku =  "Standard"
 
}
resource "azurerm_network_interface" "bastion_linuxvm_nic" {
  name = "${local.resource_name_prefix}-bastion-linuxvm-nic"
  resource_group_name = azurerm_resource_group.rg.name 
  location =  azurerm_resource_group.rg.location
  ip_configuration {
    name                          = "bastion-linux-ip"
    subnet_id                     = azurerm_subnet.bastionsubnet.id 
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.bastion_linuxvm_publicip.id 
  }
}
resource "azurerm_linux_virtual_machine" "bastion_host_linuxvm" {
  name = "${local.resource_name_prefix}-bastion-linuxvm"
  #computer_name = "weblinuxvm" #hostname of the vm(optional)
  resource_group_name = azurerm_resource_group.rg.name 
  location =  azurerm_resource_group.rg.location
  size = "Standard_DS1_v2"
  admin_username = "azureuser"
  network_interface_ids = [azurerm_network_interface.bastion_linuxvm_nic.id]
  admin_ssh_key {
    username = "azureuser"
    public_key = file("${path.module}/ssh-keys/terraform.pub")
  }
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Redhat"
    offer = "RHEL"
    sku = "83-gen2"
    version = "latest"
  }
 # custom_data = filebase64("${path.module}/app-scripts/redhat-webvm-script.sh")
 custom_data = base64encode(local.web_vm_custom_data)
}*/