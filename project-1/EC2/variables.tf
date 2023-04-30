# defining variables for my code
variable "ami" {
  description = "creating a variable to retain the value of my ami"
  type        = string
  default     = "ami-009c5f630e96948cb"
}

variable "key_name" {
  description = "creating a variable to retain the value of my key name"
  type        = string
  default     = "boy-keys"
}
