module "webserver" {
  source        = "./modules/webserver"
  key_name      = "${var.key_name}"
  image_id      = "${var.image_id}"
  instance_type = "t2.small"
  key           = file("${path.module}/id_rsa.pub")
  access_key    = "${var.secret_key}"
  secret_key    = "${var.access_key}"
}

output "mypublicIP" {
  value = module.webserver.publicIP
}

