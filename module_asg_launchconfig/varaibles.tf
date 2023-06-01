variable "aws_region" {
  description = "default region"
  type        = string
}

variable "project_name" {
  description = "name of project"
  type        = string
}

variable "public_key" {
  description = "public key material"
  type        = string
}

variable "vpc_cidr" {
  description = "cidr of our vpc"
  type        = string
}

variable "the-count" {
  description = "number of instances"
  type        = number
  default     = 3
}

variable "instance_type" {
  description = "instance type"
  type        = string
}

variable "elb_tg_name" {
  type    = string
  default = ""
}

variable "lb_tg_arn" {
  type    = string
  default = ""
}


variable "subnet_ids" {
  description = "subnet in whic to launc instances"
  type        = list(string)
  default     = []
}
/*
variable "alb_security_group" {
  description = "load balance security group"
  type = string
}
*/