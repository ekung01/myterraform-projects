# terraform block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider.
provider "aws" {
  region = "us-west-2"
}

# Create a VPC
resource "aws_vpc" "my-vpc" {
  cidr_block = var.my-vpc_cidr_block
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

 tags = {
    Name = "my-vpc"
  }
}
# creating subnets
resource "aws_subnet" "publicSubnet1" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.publicSubnet1_cidr_block  
}

resource "aws_subnet" "publicSubnet2" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.publicSubnet2_cidr_block   
}

resource "aws_subnet" "privateSubnet1" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.privateSubnet1_cidr_block 
}

resource "aws_subnet" "privateSubnet2" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.privateSubnet2_cidr_block
}