#Create Bastion host in one of the Public subnets.
module "ec2-bastion" {
  depends_on = [module.vpc]
  source     = "terraform-aws-modules/ec2-instance/aws"
  version    = "~>3.0"

  name = "LinuxBastion-host"

  ami                    = data.aws_ami.amzlinux.id
  instance_type          = var.ins_type
  key_name               = "ec2-login"
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  subnet_id              = module.vpc.public_subnets[0]

}
