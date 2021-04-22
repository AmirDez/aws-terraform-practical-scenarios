# Define the security group for Web Server, Allow incoming/Outgoing HTTP connections & SSH access & Ping access
resource "aws_security_group" "sgweb" {
  name        = "vpc_test_web"
  description = "Allow incoming/Outgoing HTTP connections & SSH access & Ping access"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = module.vpc.vpc_id

  tags = {
    Name = "Web Server SG"
  }
}