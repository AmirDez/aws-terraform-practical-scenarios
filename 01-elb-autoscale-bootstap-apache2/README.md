# Scenario 01 - Scalable ELB

We covered a scenario for making an auto scalable ELB (Elastic Load Balancer) with public and private Zones, ec2s with apache2 are placed in private zone. LB is placed in public zone.

## How its done

1 - The File is Commented out on every object you may find some useful info in the files

2 - the ec2 instances are bootstaped by a shell script (install.sh) for installing apache2 and making modification to main index.html

3 - For VPC used a best practice as a **module** instead on handling all the complexity of:

    - NATing
    - EIP (Elastic IP addresses)
    - Private Subnets
    - Public Subnets
    - Routing between Private2Public, Public2Internet

4 - Auto scaling group is configured as:

    - Minimum size of 1 and maximum size of 3
    - Write a life cycle policy with the following parameters:
        - scale in : CPU utilization > 80%
        - scale out : CPU Utilization < 60%
