terraform {
 backend "s3" {
   bucket = "malhar-tf-state"
   region = "ap-south-1"
   key    = "terraform.tfstate"
   dynamodb_table = "Terraform_tfstate"
 }
}

variable "secret_key" {
  type = string
}

variable "access_key" {
  type = string
}

provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAQ6FFPXUL3ACTJ3GD"
  secret_key = "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"
}

resource "aws_instance" "web" {
  ami           = "ami-0ded8326293d3201b"
  instance_type = "t2.micro"
}
