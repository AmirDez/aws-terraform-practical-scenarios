/* 
Using a separate file to managing multiple variables,
for better mobility of the project
*/

aws_region = "us-west-2"
vpc_cidr = "10.0.0.0/16"
private_subnet_cidr = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnet_cidr = ["10.0.101.0/24", "10.0.102.0/24"]
azs = ["us-west-2a", "us-west-2b"]
webservers_ami = "ami-830c94e3"
instance_type = "t2.micro"
key_path = "~/.ssh/id_rsa.pub"
