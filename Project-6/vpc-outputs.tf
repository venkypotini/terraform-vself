#Outputs for the VPC.

# AZ details.
output "vpc-az-list" {
  value = module.vpc.azs
}
# Private subnets
output "vpc-private-subnets" {
  value = module.vpc.private_subnets
}
# Nat gateway public ip
output "nat-gateway-ips" {
  value = module.vpc.nat_public_ips
}
# Internet gateway id
output "Internet-gateway-ip" {
  value = module.vpc.igw_id
}
# Public subnets
output "vpc-public-subnets" {
  value = module.vpc.public_subnets
}
