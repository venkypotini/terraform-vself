variable "names"{
    type = list(string)
    default = ["EC2-Demo-1", "EC2-Demo-2"]
}

variable "region" {
    type = string
    default = "eu-west-2"

}

variable "login_key"{
    type = string
    default = "ec2-login"
}
