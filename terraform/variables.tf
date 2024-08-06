variable "cluster_name" {
  type        = string
}

variable "vpc_name" {
  type        = string
}

variable "vpc_cidr" {
  type        = string
}

variable "private_subnets_cidr" {
  description = "subnets cidr"
  type = list(string)
}

variable "public_subnets_cidr" {
  type = list(string)
  description = "cidr for public subnets"
}
