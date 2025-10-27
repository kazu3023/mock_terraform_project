#================================
# VPC
#================================
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.project_name}_${var.env}_vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${var.region}c", "${var.region}c"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
  intra_subnets   = ["10.0.201.0/24", "10.0.202.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
}
