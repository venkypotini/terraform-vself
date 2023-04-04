variable "region" {
    type = string
    default = "eu-west-2"
}
variable "ins_type" {
    type = string
    default = "t3.micro"
}

variable "ec2_key" {
    default = "ec2-login"
}
