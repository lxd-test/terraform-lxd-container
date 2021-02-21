variable "consul-server" {
  type    = string
  default = "consul01-primary"
}

variable "dc-num" {
  default = 0
}

variable "dc-name" {
  default = "az1"
}

variable "iface" {
  default = "eth0"
}

variable "image" {
  default = "images:ubuntu/bionic"
}

variable "prefix" {
  default = "container"
}

variable "role" {
  type    = string
  default = "primary"
}

variable "lxd-profile" {
  type    = list(any)
  default = ["default"]
}

variable "license" {
  type    = string
  default = ""
}

variable "template" {}
