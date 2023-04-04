module "ec2-private-app2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.17.0"

  depends_on = [module.vpc.vpc_id]

  name                   = "private-app2-${count.index}"
  ami                    = data.aws_ami.amzlinux.id
  instance_type          = var.inst_type
  key_name               = "ec2-login"
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  subnet_ids             = [module.vpc.private_subnets[0], module.vpc.private_subnets[1]]
  user_data              = file("${path.module}/app2-user-script.sh")
  instance_count         = 2
}
