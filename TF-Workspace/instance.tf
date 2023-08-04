# Creating an EC2 Instance
resource "aws_instance" "Instance" {
  ami           = var.image_id
  instance_type = var.instance_type
}


