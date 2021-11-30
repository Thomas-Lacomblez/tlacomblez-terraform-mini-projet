data "aws_ami" "ubuntu_aws_ami" {
  most_recent = true
  owners = ["${var.author}"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

resource "aws_instance" "ensup-tlacomblez-ec2" {
  ami             = data.aws_ami.my_ubuntu_ami.id
  instance_type   = var.instance_type
  key_name        = var.ssh_key
  availability_zone = "${var.az}"
  security_groups = ["${var.sg_name}"]
  tags = {
    Name = "ensup-${var.author}-ec2"
  }

  provisioner "local-exec" {
    command = " echo ip public : ${var.public_ip} ; ID: ${aws_instance.ensup-tlacomblez-ec2.id} ; AZ: ${aws_instance.ensup-tlacomblez-ec2.availability_zone}; >> infos_ec2.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ] 
    connection {
      type        = "ssh"
      user        = "${var.user}"
      private_key = file("E:/dev/terraform/.aws/${var.ssh_key}.pem")
      host        = "${self.public_ip}"
    }
  }

}

