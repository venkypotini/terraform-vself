#EC2 instance output:
#Bastion host details.

output "Bastion_host_public_ip" {
  value = module.ec2-bastion.public_ip
}

output "Bastion_host_id" {
  value = module.ec2-bastion.id
}
#ec2 privage details.


output "private_host_private_ip" {
  value = module.ec2-private.private_ip
}

output "ec2-private_host_id" {
  value = module.ec2-private.id
}
