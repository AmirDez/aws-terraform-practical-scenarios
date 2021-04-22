
# Define the security group for Web 
resource "aws_security_group" "sgweb" {
  name        = "vpc_test_web"
  description = "Allow incoming/Outgoing HTTP connections To Web Servers Only from LoadBalancer"

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.sglb.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = module.vpc.vpc_id

  tags = {
    Name = "SG Web Server"
  }
}


# Define the security group for LoadBalancer
resource "aws_security_group" "sglb" {
  name        = "vpc_test_lb"
  description = "Allow incoming/Outgoing HTTP connections To LoadBalancer"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = module.vpc.vpc_id

  tags = {
    Name = "SG Load Balancer"
  }
}