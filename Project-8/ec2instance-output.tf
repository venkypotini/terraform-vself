#EC2 instance output:
#Bastion host details.

output "Bastion_host_public_ip" {
  value = module.ec2-bastion.public_ip
}

output "Bastion_host_id" {
  value = module.ec2-bastion.id
}
#ec2 privage details.

/*
output "private_host_private_ip" {
  value = module.ec2-private-app1[*].private_ip
}

output "ec2-private-app1_host_id" {
  value = module.ec2-private-app1[*].id
}

output "ec2-private-app2_host_id" {
  value = module.ec2-private-app2[*].id
}
*/
