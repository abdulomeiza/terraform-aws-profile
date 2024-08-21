resource "aws_instance" "profile-bastion" {
  ami                    = lookup(var.AMI, var.REGION)
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.profilekey.key_name
  subnet_id              = module.vpc.public_subnets[0]
  count                  = var.instance_count
  vpc_security_group_ids = [aws_security_group.profile-bastion-sg.id]

  tags = {
    Name    = "profile-bastion"
    PROJECT = "profile"
  }

  provisioner "file" {
    content     = templatefile("templates/db-deploy.tmpl", { rds-endpoint = aws_db_instance.profile-rds.address, dbuser = var.dbuser, dbpass = var.dbpass })
    destination = "/tmp/profile-dbdeploy.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/profile-dbdeploy.sh",
      "sudo /tmp/profile-dbdeploy.sh"
    ]
  }

  connection {
    user        = var.USERNAME
    private_key = file(var.PRIV_KEY_PATH)
    host        = self.public_ip
  }

  depends_on = [aws_db_instance.profile-rds]
}


