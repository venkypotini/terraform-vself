# Creating VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.0"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs              = ["eu-west-2a", "eu-west-2b"]
  private_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets   = ["10.0.101.0/24", "10.0.102.0/24"]
  database_subnets = ["10.0.151.0/24", "10.0.152.0/24"]

  enable_nat_gateway                 = true
  single_nat_gateway                 = true
  create_database_subnet_route_table = true
  create_database_nat_gateway_route  = false

  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support   = true

}

output "sub_id"{
  value = module.vpc.private_subnets
}
