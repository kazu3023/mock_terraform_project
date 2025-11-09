#---------------------------------#
# Keypair
#---------------------------------#
resource "aws_key_pair" "bastion" {
  key_name   = "${var.system_name}-${var.env}-bastion-key"
  public_key = file("~/.ssh/${var.system_name}-${var.env}-bastion-key.pub")
  tags = {
    "Name" = "bastion-key"
  }
}

resource "aws_key_pair" "web" {
  key_name   = "${var.system_name}-${var.env}-web-key"
  public_key = file("~/.ssh/${var.system_name}-${var.env}-web-key.pub")
  tags = {
    "Name" = "web-key"
  }
}
