# Define the vpc with the cidr
resource "aws_vpc" "terra-project-vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = "terra-project-vpc"
  }
}
# Declare the data source for availability zone
data "aws_availability_zones" "available" {
  state = "available"
}

# public subnet 1
resource "aws_subnet" "terra-project_pub_subnet1" {
  vpc_id            = aws_vpc.terra-project-vpc.id
  cidr_block        = var.public_subnet1_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
 
  tags = {
    Name = "terra-project_pub_subnet1"
  }
}

#association public subnet1 to route table
resource "aws_route_table_association" "public_subnet1" {
  subnet_id      = aws_subnet.terra-project_pub_subnet1.id
  route_table_id = aws_route_table.terra-project_pub_RT.id
}

#public subnet2
resource "aws_subnet" "terra-project_pub_subnet2" {
  vpc_id            = aws_vpc.terra-project-vpc.id
  cidr_block        = var.public_subnet2_cidr
  availability_zone = data.aws_availability_zones.available.names[1]
 
  tags = {
    Name = "terra-project_pub_subnet2"
  }
}

# public subnet2 route tabble association
resource "aws_route_table_association" "public_subnet2" {
  subnet_id      = aws_subnet.terra-project_pub_subnet2.id
  route_table_id = aws_route_table.terra-project_pub_RT.id
}


#private subnet1
resource "aws_subnet" "terra-project_priv_subnet1" {
  vpc_id            = aws_vpc.terra-project-vpc.id
  cidr_block        = var.private_subnet1_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
  
  tags = {
    Name = "terra-project_priv_subnet1"
  }
}
#private subnet2
resource "aws_subnet" "terra-project_priv_subnet2" {
  vpc_id            = aws_vpc.terra-project-vpc.id
  cidr_block        = var.private_subnet2_cidr
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "terra-project_priv_subnet2"
  }
}
# Internet gateway
resource "aws_internet_gateway" "terra-project_igw" {
  vpc_id = aws_vpc.terra-project-vpc.id
  tags = {
    Name = "terra-project_igw"
  }
}

#creatiin route table
resource "aws_route_table" "terra-project_pub_RT" {
  vpc_id = aws_vpc.terra-project-vpc.id

  tags = {
    Name = "terra-project_pub_RT"
  }
}
# creatig route
resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.terra-project_pub_RT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.terra-project_igw.id
}

data "aws_ami" "my_linux2_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
}

# create an ec2 instance
resource "aws_instance" "my_linux2" {
  ami                    = data.aws_ami.my_linux2_ami.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  subnet_id              = aws_subnet.terra-project_pub_subnet1.id

  tags = {
    Name = "my_linux2_instance"
  }
}

resource "aws_security_group" "web_sg" {
  description = "security group for my public instsnces"
  name        = "web_sg"
  vpc_id      = aws_vpc.terra-project-vpc.id

  ingress {
    description = "ssh access from the vpc"
    from_port   = "22"
    to_port     = "22" 
    protocol    = "tcp"
    cidr_blocks = [var.public_subnet1_cidr, var.public_subnet2_cidr]
  }

  ingress {
    description = "web access"
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["69.143.55.226/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web_sg"
  }
}
