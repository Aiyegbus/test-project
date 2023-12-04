variable "instance_name" {
  description = "test instance"
  default     = "test_instance"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  description = "ami to use"
  default     = "ami-0f8e81a3da6e2510a"
}

variable "number_of_instances" {
  description = "number of instances"
  default     = 1
}

variable "ami_key_pair_name" {
  description = "key pair"
  default     = "ayoterraformkey"
}

variable "vpc_cidr" {
  description = "cidr block"
  default     = "10.0.0.0/16"
}

variable "subnet_count" {
  default = 2
}

variable "az_count" {
  default = 2
}
