# Data source
data "aws_ami" "amazon-linux" {
  most_recent = true
  owners      = ["${var.owner_id}"]

  filter {
    name   = "name"
    values = ["${var.image_name}"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]

  }
}

output "ami_id" {
  value = data.aws_ami.amazon-linux.id
}




# Creating an EC2 Instance
resource "aws_instance" "Instance" {
  ami                    = data.aws_ami.amazon-linux.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key-tf.key_name
  vpc_security_group_ids = [aws_security_group.sg-terraform.id] # Use a list for security group IDs

  tags = {
    Name = "Terraform_1st_Instance"
  }
  user_data = file("${path.module}/script.sh")

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("${path.module}/id_rsa")
    host        = self.public_ip
  }

  #file, local-exec, remote-exec

  #1) file

  provisioner "file" {
    source      = "readme.md"      #terraform machine
    destination = "/tmp/readme.md" #remote machine
  }

  provisioner "file" {
    source      = "content.md"      #terraform machine
    destination = "/tmp/content.md" #remote machine
  }

  #2) local-exec

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > /tmp/mypublicip.txt"
  }

  provisioner "local-exec" {
    working_dir = "/tmp/"
    command     = "echo ${self.public_ip} > yourpublicip.txt"
  }

  provisioner "local-exec" {
    on_failure = continue
    interpreter = [
      "/usr/bin/python3", "-c"
    ]
    command = "print('HelloWorld')"
  }

  provisioner "local-exec" {
    command = "env>env.txt"
    environment = {
      envname = "envvalue"
    }
  }

  provisioner "local-exec" {
    command = "echo 'at create'"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo 'at delete'"
  }

  #3) remote-exec

  provisioner "remote-exec" {
    inline = [
      "ifconfig > /tmp/ifconfig.output",
      "echo 'hello malhar'>/tmp/test.txt"
    ]
  }

  provisioner "remote-exec" {
    when   = destroy #for example you can create backup in S3
    script = "./testscript.sh"
  }


}


