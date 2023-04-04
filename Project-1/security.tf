resource "aws_security_group" "ec2-ssh-http"{
    name = "${terraform.workspace}-ssh-http"
    description = "enable ssh to ec2"
    ingress{
        description = "enable port 22"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress{
        description = "enable port 80"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress{
        description = "allow all outboud connections"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
