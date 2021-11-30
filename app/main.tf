provider "aws" {
  region = "us-east-1"
  access_key = ""
  secret_key = ""
}

#Appel du module de création du sg
module "sg-ensup-tlacomblez" {
  source = "../sg"
  author = "app"

}

#Appel module de création du volume
module "ebs-ensup-tlacomblez" {
  source = "../ebs"
  dd_size = 5
  author = "app"
}

# Appel du module de création de l'adresse ip pulique
module "eip-ensup-tlacomblez" {
  source = "../eip"
}

# Appel du module de création de ec2
module "ec2-ensup-tlacomblez" {
  source = "../ec2"
  author = "app"
  instance_type = "t2.micro"
  sg_name= "${module.sg-ensup-tlacomblez.out_sg_name}"
  public_ip = "${module.eip-ensup-tlacomblez.out_eip_ip}"
  user = "ubuntu"
}

#//////////////////////////////////////////////////
#Creation des associations nécessaires entre nos ressources

resource "aws_eip_association" "eip_assoc-ensup-tlacomblez" {
  instance_id = module.ec2-ensup-tlacomblez.out_instance_id
  allocation_id = module.eip-ensup-tlacomblez.out_eip_id
}

resource "aws_volume_attachment" "ebs_att-ensup-tlacomblez" {
  device_name = "/dev/sdh"
  volume_id   = module.ebs-ensup-tlacomblez.out_vol_id
  instance_id = module.ec2-ensup-tlacomblezc2.out_instance_id
}
