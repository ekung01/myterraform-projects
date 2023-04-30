# create pub sub1 cider block
variable "my-vpc_cidr_block" {
  description = "creating a variable to retain the public subnet cider value"
  type        = string
  default     = "10.0.0.0/16"
}

variable "publicSubnet1_cidr_block" {
  description = "creating a variable to retain the public subnet cider value"
  type        = string
  default     = "10.0.1.0/24"
}

# create pub sub2 cider block
variable "publicSubnet2_cidr_block" {
  description = "creating a variable to retain the public subnet cider value"
  type        = string
  default     = "10.0.2.0/24"
}

# create priv sub1 cider block
variable "privateSubnet1_cidr_block" {
  description = "creating a variable to retain the public subnet cider value"
  type        = string
  default     = "10.0.3.0/24"
}

# create priv sub2 cider block
variable "privateSubnet2_cidr_block" {
  description = "creating a variable to retain the public subnet cider value"
  type        = string
  default     = "10.0.4.0/24"
}