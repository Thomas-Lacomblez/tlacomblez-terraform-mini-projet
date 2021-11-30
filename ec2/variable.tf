variable "author" {
  type    = string
  default = "tlacomblez"
}

variable "instance_type" {
  type    = string
  default = "t2.nano"
}

variable "ssh_key" {
  type    = string
  default = "terraform-ensup-tlacomblez"
}

variable "sg_name" {
  type    = string
  default = "sg-ensup-tlacomblez"
}

variable "public_ip" {
  type    = string
  default = "NULL"
}

variable "az" {
  type    = string
  default = "us-east-1b"
}

variable "user" {
  type    = string
  default = "NULL"
}