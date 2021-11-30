resource "aws_ebs_volume" "vol-ensup-tlacomblez" {
  availability_zone = "${var.az}"
  size              = var.size

  tags = {
    Name = "ensup-${var.author}-ebs"
  }
}