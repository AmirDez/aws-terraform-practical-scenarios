/* 
Using a separate file to managing VPC for better mobility of the project.
I used vpc best practice as a module instead on handling all the complexity of
 - NAT
 - ELP
 - Private Subnets
 - Public Subnets
 - Rounting
*/

# Create a vpn with minimum config

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  cidr   = var.vpc_cidr

  azs             = var.azs
  private_subnets = var.private_subnet_cidr
  public_subnets  = var.public_subnet_cidr

  enable_nat_gateway = true
  tags = {
    Name = "bs-default"
  }
}
