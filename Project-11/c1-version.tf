terraform {
  required_version = ">= 1.0" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws"{
    region = "eu-west-2"

}

resource "aws_instance" "timport"{
    ami = "ami-0055e70f580e9ae80"
    instance_type = "t2.micro"
    key_name = "ec2-login"

    tags = {
        Name = "terraform-import"
    }



}
