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

# configuring the resources
resource "aws_default_vpc" "default" {
  enable_dns_hostnames = true
  tags = {
    Name = "Default VPC"
  }
}
resource "aws_instance" "my_ec2" {
  ami                    = var.ami
  instance_type          = "t3.micro"
  key_name               = var.key_name
  vpc_security_group_ids = ["default"]
  tags = {
    Name = "my_ec2"
  }
}
