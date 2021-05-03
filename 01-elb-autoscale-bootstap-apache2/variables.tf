/* 
Using a separate file to managing multiple variables,
for better mobility of the project
*/

variable "aws_region" {
  default = "us-west-2"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default     = "10.0.0.0/16"
}

variable "private_subnet_cidr" {
  description = "CIDR for the private subnet"
  type        = list(any)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  type        = list(any)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "azs" {
  type    = list(any)
  default = ["us-west-2a", "us-west-2b"]
}

variable "webservers_ami" {
  default = "ami-830c94e3"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_path" {
  description = "SSH Public Key path"
  default     = "~/.ssh/id_rsa.pub"
}

