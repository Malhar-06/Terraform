# Creating Security Group
resource "aws_security_group" "sg-terraform" {
  name        = "security-group-for-tf"
  description = "Security Group for SSH and All Traffic"

  dynamic "ingress" {
    for_each = var.ports
    iterator = port
    content {
      description = "TLS from VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] # You may want to limit this to specific IPs for security reasons
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "All"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

output "securityGroupDetails" {
  value = aws_security_group.sg-terraform.id
}

