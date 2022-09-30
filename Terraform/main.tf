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

data "aws_vpc" "main" {
  id = "vpc-08188e5c7c8f81cc7"
}

resource "aws_instance" "app_server" {
  # Creates four identical aws ec2 instances
  count = 2

  ami             = "ami-06148e0e81e5187c8"
  instance_type   = "t3.medium"
  key_name        = var.aws_key_pair
  vpc_security_group_ids = [aws_security_group.neureality_sg.id]
  tags = {
    Name = "K8S No. ${count.index}"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = self.public_ip
    private_key = file("/home/gilad/Documents/Private/GRKeypair.pem")
  }
}