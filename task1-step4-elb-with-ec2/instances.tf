/*
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

# Define an webserver instance
resource "aws_instance" "webservers" {
  ami                    = var.webservers_ami
  instance_type          = var.instance_type
  subnet_id              = module.vpc.private_subnets[0]
  vpc_security_group_ids = ["${aws_security_group.sgweb.id}"]
  user_data              = file("install.sh")
  tags = {
    Name = "apache2-web-server-${0}"
  }
}

