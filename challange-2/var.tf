variable "access_key" {
  default = ""
}

variable "secret_key" {
  default = ""
}

variable "region" {
  default = "us-east-1"
}

variable "public_cidr" {
  type = list
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_cidr" {
  type = list
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}
variable "cluster-name" {
  default = "my-cluster"
  type    = string
}
