variable "aws_region" {
  description = "cidr of our vpc"
  type        = string
}

variable "vpc_cidr" {
  description = "cidr of our vpc"
  type        = string
}
variable "public_subnet1_cidr" {
  description = "cidr of the public subnet 1"
  type        = string
}
variable "public_subnet2_cidr" {
  description = "cidr of the public subnet 2"
  type        = string
}
variable "private_subnet1_cidr" {
  description = "cidr of the private subnet 1"
  type        = string
}
variable "private_subnet2_cidr" {
  description = "cidr of the private subnet 2"
  type        = string
}
/*variable "availability_zone" {
  description = "map of the AZs"
  type        = map(string)
  default = {
    "public_subnet1"  = "us-west-2a"
    "public_subnet2"  = "us-west-2b"
    "private_subnet1" = "us-west-2a"
    "private_subnet2" = "us-west-2b"
  }
}*/

variable "key_name" {
  description = "my ssh key name"
  type        = string
}

variable "default_route_cidr" {
  description = "default route_cidr"
  type        = string
}