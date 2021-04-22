/* 
Using a separate file to managing multiple providers,
of course we need only one provider in this assignment.
*/

provider "aws" {
  region = var.aws_region
}