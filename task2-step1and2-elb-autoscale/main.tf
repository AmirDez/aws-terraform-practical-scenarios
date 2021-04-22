/*
Task2
  Create an auto scaling group with minimum size of 1 and maximum size of 3 with load balancer
  created in step 3.

 It makes 
  - A listener which is enable to handle traffic on http port 80 and backend traffic on 80.
  - Has a health check pn port specific address HTTP:80/index.html.
  - Shows the dns name of elb for users access at the end.
*/

# Create a new launcher config for autoscaler to guide through spinning up en2s
resource "aws_launch_configuration" "web" {
  image_id        = var.webservers_ami
  instance_type   = var.instance_type
  security_groups = ["${aws_security_group.sgweb.id}"]
  user_data       = file("install.sh")
  name_prefix     = "apache2-web-server-autoscale-"
  # associate_public_ip_address = true # Just for Testing
  lifecycle {
    create_before_destroy = true
  }
}

# Create a new autoScallingGroup with it properties: Min and Max Count of servers and etc...
resource "aws_autoscaling_group" "web" {
  name = aws_launch_configuration.web.name

  min_size         = 1
  desired_capacity = 2
  max_size         = 3

  health_check_type = "ELB"
  load_balancers = [
    aws_elb.bs-elb.id
  ]

  launch_configuration = aws_launch_configuration.web.name //ataching ec2 launcher to the autoScallingGroup

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity = "1Minute"

  vpc_zone_identifier = module.vpc.private_subnets    //We wanted to ec2s place in private zone thats why we needed NATing

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${aws_launch_configuration.web.name}"
    propagate_at_launch = true
  }
}

// Monitoring the CPU Spec of the web servers
resource "aws_autoscaling_policy" "web_policy_up" {
  name                   = "web_policy_up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.web.name
}

// The logic behind change number of ec2s
resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_up" {
  alarm_name          = "web_cpu_alarm_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web.name
  }

  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions     = [aws_autoscaling_policy.web_policy_up.arn]
}

resource "aws_autoscaling_policy" "web_policy_down" {
  name                   = "web_policy_down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.web.name
}

resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_down" {
  alarm_name          = "web_cpu_alarm_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "60"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web.name
  }

  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions     = [aws_autoscaling_policy.web_policy_down.arn]
}

