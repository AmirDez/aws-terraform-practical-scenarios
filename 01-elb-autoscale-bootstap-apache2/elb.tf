
/*
It makes 
  - A listener which is enable to handle traffic on http port 80 and backend traffic on 80.
  - Has a health check pn port specific address HTTP:80/index.html.
  - Shows the dns name of elb for users access at the end.

  I sepetated the main file for better readability of the code
*/

# Create a new load balancer (With out instcance)
resource "aws_elb" "bs-elb" {
  name            = "bs-elb"
  subnets         = module.vpc.public_subnets
  security_groups = [aws_security_group.sglb.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/index.html"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 100
  connection_draining         = true
  connection_draining_timeout = 300

  tags = {
    Name = "bs-elb"
  }
}

output "elb-dns-name" {
  value = aws_elb.bs-elb.dns_name
}
