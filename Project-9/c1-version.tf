terraform{
    required_version = ">= 0.12"
    required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.48.0"
    }
    }
}

provider "aws" {
    region = var.aws_region

}

variable "aws_region"{
    default = "eu-west-2"
}
