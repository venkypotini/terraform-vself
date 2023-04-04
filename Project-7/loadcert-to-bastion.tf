resource "null_resource" "bstcert" {
  # Connect to the Bastion host

  connection {
    type        = "ssh"
    host        = module.ec2-bastion.public_ip
    user        = "ec2-user"
    private_key = file("private-key/ec2-login.pem")
    timeout     = "10s"
  }

  provisioner "file" {
    source      = "private-key/ec2-login.pem"
    destination = "/home/ec2-user/ec2-login.pem"
  }

  provisioner "remote-exec" {
    inline = ["sudo chmod 400 /home/ec2-user/ec2-login.pem"]
  }

}
