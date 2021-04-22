/*
 Task1 Step2
Launch an ec2 instance with a role inside the private subnet of VPC, and install apache through bootstrapping.

It does: 
 - Makes an ec2 instance and install apache2 in it with install.sh file
 - A specifec sec group is made for the web servers with incoming port 80
 - Is uses one of subnets in out VPC which is created.
*/

# Define SSH key pair for our instances
resource "aws_key_pair" "default" {
  key_name   = "testkeypair"
  public_key = file("${var.key_path}")
}

# Define webserver inside the public subnet
resource "aws_instance" "wb" {
  ami                    = var.webservers_ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.default.id
  subnet_id              = module.vpc.private_subnets[0]
  vpc_security_group_ids = ["${aws_security_group.sgweb.id}"]
  #associate_public_ip_address = true #Just For Testing Porpose
  source_dest_check = false
  user_data         = file("install.sh")
  tags = {
    Name = "apache2-web-server"
  }
}