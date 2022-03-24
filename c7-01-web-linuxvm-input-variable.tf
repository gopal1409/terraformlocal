#here we can put input variable for linux vm
variable "web_linuxvm_instance_count" {
  type = number
  default = 2
  
}

variable "lb_inbound_nat_ports" {
  type = list(string)
  default = ["1022","2022","4022","5022"]
}
