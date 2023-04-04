#Get the list of availability zones in a region.
data "aws_availability_zones" "eu-west-2" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

output "aznames"{
    value = data.aws_availability_zones.eu-west-2.names
}

# Check if instance_type is supported.

data "aws_ec2_instance_type_offerings" "az_avail" {
  for_each = toset(data.aws_availability_zones.eu-west-2.names)
  filter {
    name   = "instance-type"
    values = ["t3.micro"]
  }

  filter {
    name   = "location"
    values = [each.key]
  }

  location_type = "availability-zone"
}
/*
output "az_avail_names"{
    value = data.aws_ec2_instance_type_offerings.az_avail
}
*/
