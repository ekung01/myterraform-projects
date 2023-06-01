
# Data source getting the default VPC id
data "aws_vpc" "default" {
  default = true
}

# creating three identitical instances using count
resource "aws_instance" "project3-intance" {
  count                  = var.the-count
  instance_type          = var.instance_type
  ami                    = data.aws_ami.my_linux2_ami.id
  key_name               = aws_key_pair.myboys-key.key_name  #var.key_name #key_name = aws_key_pair.newboy-key.key_name
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_security_group_ids = ["${aws_security_group.myweb_sg.id}" ]
  associate_public_ip_address = "true"

   user_data = <<-EOF
    #!/bin/bash
    sudo amazon-linux-extras install nginx1.12 -y
    sudo nginx
  EOF

  tags = {
    Name = "project3-${var.project_name}"
  }
}

# sourcin for the lastest AMI
data "aws_ami" "my_linux2_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
}

# web instance security group
resource "aws_security_group" "myweb_sg" {
  description = "security group for my public instsnces"
  name        = "myweb_sg"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "ssh access from the vpc"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description                = "receives traffic from elb"
    from_port                  = 80
    to_port                    = 80
    protocol                   = "tcp"
    security_groups = [aws_default_security_group.alb_sg.id] # insert the sg of the alb and remove the cidr
  }

  ingress {
    description                = "receives traffic from elb"
    from_port                  = 443
    to_port                    = 443
    protocol                   = "tcp"
    security_groups = [aws_default_security_group.alb_sg.id] # insert the sg of the alb and remove the cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "myweb_sg-${var.project_name}"
  }
}

# Load balancer security group
resource "aws_default_security_group" "alb_sg" {
  vpc_id = data.aws_vpc.default.id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb_sg-${var.project_name}"
  }
}

# Data source getting the default AZs id
data "aws_availability_zones" "available" {
  state = "available"
}

# Data source getting the default subnets id
data "aws_subnets" "subnets" {}

data "aws_subnet" "subnet" {
  for_each = toset(data.aws_subnets.subnets.ids)
  id       = each.value
}

# creating a load balancer and linking subnets
resource "aws_lb" "project3_alb" {
  count = var.the-count > 2 ? 1 : 0
  name               = "project3-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    =  [aws_default_security_group.alb_sg.id] 
  subnets = [for subnet in data.aws_subnet.subnet : subnet.id]
  enable_deletion_protection = false

  tags = {
    Name = "alb-${var.project_name}"
  }
}

# generating key-pair for the instance
resource "aws_key_pair" "myboys-key" {
  key_name = "myboys-key"
  public_key = var.public_key

  tags = {
    name = "myssh key"
  } 
}

# creating listener for the load balancer
resource "aws_lb_listener" "front_end" {

  load_balancer_arn = aws_lb.project3_alb[0].arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

# creatting target group
resource "aws_lb_target_group" "target_group" {
  depends_on = [aws_instance.project3-intance]
  name     = "my-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    unhealthy_threshold = 2
    timeout             = 5
  }
}

# linking target group to
resource "aws_lb_target_group_attachment" "target_group_attachment" {
  count = var.the-count
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_instance.project3-intance[count.index].id
  port             = 80
}
