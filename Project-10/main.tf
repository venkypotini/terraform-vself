terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.49.0"
    }
  }

}

provider "aws" {
  region = var.aws_region
}
module "createwebsite" {
  source = "./modules/venkyawss3"
  bucket_name = var.bucket_name

}

variable "aws_region" {
  default = "eu-west-2"
}

variable "bucket_name" {
  default = "venkywb102"
}
