module impsg {
       source = "./modules"
}

resource "aws_instance" "myec2"{
    ami = data.aws_ami.amzlinux2.id
    instance_type = "t3.micro"
    vpc_security_group_ids = [module.impsg.secgp_id]

}


data "aws_ami" "amzlinux2" {
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
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}
output ec2pubip{
    value = aws_instance.myec2.public_ip
}
