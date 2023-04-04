resource "aws_instance" "myec2vm"{
    instance_type =  var.ins_type
    ami = data.aws_ami.amzlinux.id
    key_name = var.ec2_key
    for_each = toset(keys({for az, details in data.aws_ec2_instance_type_offerings.az_avail : az =>
    details.instance_types if length(details.instance_types) != 0}))
    availability_zone =  each.value
    tags ={
        Name = "Project-2-${each.key}"

    }

}

data "aws_ami" "amzlinux" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami*-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
