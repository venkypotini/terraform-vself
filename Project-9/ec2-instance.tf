data "aws_ami" "amzlinux" {
  most_recent = true
  owners      = ["amazon"]

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

resource "aws_instance" "web" {

  for_each = toset(flatten([for subnets in module.vpc.private_subnets: subnets]))
  ami           = data.aws_ami.amzlinux.id
  instance_type = "t3.micro"
  subnet_id = each.key

}
