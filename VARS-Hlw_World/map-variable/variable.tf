variable "userage" {
   type = map
   default = {
      malhar = 20
      ahilya = 16
      aadishri = 13
   }
}

variable "username" {
   type = string
}


output "userage" {
   
   value = "my name is ${var.username} and my age is ${lookup(var.userage,"${var.username}")}"
}
