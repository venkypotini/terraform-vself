# Terraform Block
terraform {
  required_version = ">= 1.0" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  /*
backend "s3"{
  backend = "s3-bucket"
  key = "/location/terraform.tfstate"
  region = "eu-west-2"
  dynamodb_table = "table-name"
}
*/
}
# Provider Block
provider "aws" {
  region = var.region
}




# Resource: EC2 Instance
resource "aws_instance" "myec2vm" {
  ami = data.aws_ami.amzlinux2.id
  instance_type = "t3.micro"
  count = terraform.workspace == "default" ? 2:1
  vpc_security_group_ids = [aws_security_group.ec2-ssh-http.id]
  key_name = var.login_key
   tags = {
    "Name" = "vm-${terraform.workspace}-${count.index}"

  }
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("./ec2-login.pem")
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y httpd",
      "sudo systemctl start httpd",
    ]
  }

  provisioner "file" {
    source = "index.html"
    destination = "/var/www/html/index.html"
    on_failure = continue
  }

}

output "instance_ip_addr" {
  value = aws_instance.myec2vm[*].public_ip
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
