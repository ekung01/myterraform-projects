# terraform block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.65.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-west-2"
}

#configuring resources
resource "aws_default_vpc" "default" {
  enable_dns_hostnames = true
  tags = {
    Name = "Default VPC"
  }
}
/*
data "aws_ami" "ubuntu1604" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
*/
data "aws_ami" "ubuntu5723" {
  most_recent = true

  filter {
    name   = "name"
    values =   ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"] #["my-ami"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "my_ec2" {
  ami                    = data.aws_ami.ubuntu5723.id #var.ami
  instance_type          = "t2.micro"
  key_name               = "boy-keys" #var.key_name
  vpc_security_group_ids = ["default"]
  tags = {
    Name = "my_ec2"
  }
}
