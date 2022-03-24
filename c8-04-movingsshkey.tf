/*resource "null_resource" "null_copy_ssh_key_to_bastion" {
  depends_on = [
    azurerm_linux_virtual_machine.bastion_host_linuxvm
  ]
  #so we will create a connection block to connect to azure vm
  
  
  #once the connection has been made move the terrafoprm-key.pem to /tmp/terraform-key.pem
  provisioner "file" {
    source = "ssh-keys/terraform-azure.pem" #from localmachine
    destination = "/tmp/terraform-azure.pem" #insidew your bastion host to the remote machine
  }
  #remote exec using the same i ll fix the permission issue
  provisioner "remote-exec" {
    inline = [
        "sudo chmod 400 /tmp/terraform-azure.pem" #then i am changing the permission.
    ]
  }
}*/