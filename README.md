# Building auto scalable load balancer with terraform on AWS

## Task1-Step1
Create a role with s3 access

## Task1-Step2
Launch an ec2 instance with a role inside the private subnet of VPC, and install apache2 through bootstrapping.

## Task1-Step3
Create a load balancer in public subnet with an ec2 instance,

## Task1-Step4
Adding an ec2 instance running apache2 with simple install.sh which installs it and makes an index.html contains hostname under the load balancer

## Task2
We covered a scenario for making an auto scalable ELB with public and private Zones, apache2 ec2s are placed in private zone. LB is placed in public zone.

