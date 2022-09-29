terraform {
  required_version = ">= 1.2.0"
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "app_server" {
  # Creates four identical aws ec2 instances
  count = 2

  ami             = "ami-06148e0e81e5187c8"
  instance_type   = "t3.medium"
  key_name        = var.aws_key_pair
  security_groups = ["neureality_sg"]
  tags = {
    Name = var.instance_name
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = self.public_ip
    private_key = file("/home/gilad/Documents/Private/GRKeypair.pem")
  }
}