resource "null_resource" "null_copy_ssh_key_to_bastion" {
  depends_on = [
    azurerm_linux_virtual_machine.bastion_host_linuxvm
  ]
  #so we will create a connection block to connect to azure vm
  connection {
    type = "ssh"
    host = azurerm_linux_virtual_machine.bastion_host_linuxvm.public_ip_address
    user = azurerm_linux_virtual_machine.bastion_host_linuxvm.admin_username
    private_key = file("${path.module}/ssh-keys/terraform-azure.pem")
  }
  #once the connection has been made move the terrafoprm-key.pem to /tmp/terraform-key.pem
  provisioner "file" {
    source = "ssh-keys/terraform-azure.pem"
    destination = "/tmp/terraform-azure.pem" #insidew your bastion host
  }
  #remote exec using the same i ll fix the permission issue
  provisioner "remote-exec" {
    inline = [
        "sudo chmod 400 /tmp/terraform-azure.pem"
    ]
  }
}