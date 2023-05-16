# output vpc_id
output "terra-project-vpc_id" {
  value = aws_vpc.terra-project-vpc.id
}

# output pub subnet 1 id
output "terra-project_pub_subnet1_id" {
  value = aws_subnet.terra-project_pub_subnet1.id
}

# output pub subnet 2 id
output "terra-project_pub_subnet2_id" {
  value = aws_subnet.terra-project_pub_subnet2.id
}

# output priv subnet 1 id
output "terra-project_priv_subnet1_id" {
  value = aws_subnet.terra-project_priv_subnet1.id
}

# output priv subnet 2 id
output "terra-project_priv_subnet2_id" {
  value = aws_subnet.terra-project_priv_subnet2.id
}

# output Internet gateway id
output "terra-project_igw_id" {
  value = aws_internet_gateway.terra-project_igw.id
}

# output project pub_RT id
output "terra-project_pub_RT" {
  value = aws_route_table.terra-project_pub_RT.id
}

# output ami id
output "my_linux2_ami" {
    value = data.aws_ami.my_linux2_ami.id
}

# output web sg id
output "web_sg" {
    value = aws_security_group.web_sg.id
}
