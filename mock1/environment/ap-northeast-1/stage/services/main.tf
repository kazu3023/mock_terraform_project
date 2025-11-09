#---------------------------------#
# AMI
#---------------------------------#
# 最新のAmazonLinux2023のAMIを取得
data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

#---------------------------------#
# Bastion
#---------------------------------#
resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.al2023.id
  instance_type               = var.instance_type_bastion
  associate_public_ip_address = true

  subnet_id       = data.terraform_remote_state.vpc.outputs.public_subnets[0]
  vpc_security_group_ids = [data.terraform_remote_state.sg.outputs.sg_bastion]

  key_name = aws_key_pair.bastion.key_name
  tags = {
    Name = "${var.system_name}-${var.env}-bastion"
  }
}

#---------------------------------#
# Web
#---------------------------------#
resource "aws_instance" "web_a" {
  ami           = data.aws_ami.al2023.id
  instance_type = var.instance_type_web

  subnet_id       = data.terraform_remote_state.vpc.outputs.private_subnets[0]
  vpc_security_group_ids = [data.terraform_remote_state.sg.outputs.sg_web]

  key_name = aws_key_pair.web.key_name
  tags = {
    Name = "${var.system_name}-${var.env}-web-a"
  }
}

resource "aws_instance" "web_c" {
  ami           = data.aws_ami.al2023.id
  instance_type = var.instance_type_web

  subnet_id       = data.terraform_remote_state.vpc.outputs.private_subnets[1]
  vpc_security_group_ids = [data.terraform_remote_state.sg.outputs.sg_web]

  key_name = aws_key_pair.web.key_name
  tags = {
    Name = "${var.system_name}-${var.env}-web-c"
  }
}
