locals {
  myip = "175.177.49.22/32"
}

#---------------------------------#
# ALB
#---------------------------------#

#---------------------------------#
# Bastion
#---------------------------------#
resource "aws_security_group" "bastion" {
  name   = "${var.system_name}-${var.env}-sg-bastion"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  
  tags = {
    Name = "${var.system_name}-${var.env}-sg-bastion"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "bastion" {
  security_group_id = aws_security_group.bastion.id
  cidr_ipv4         = local.myip
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "bastion" {
  security_group_id = aws_security_group.bastion.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

#---------------------------------#
# Web
#---------------------------------#
resource "aws_security_group" "web" {
  name   = "${var.system_name}-${var.env}-sg-web"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  tags = {
    Name = "${var.system_name}-${var.env}-sg-web"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "web" {
  security_group_id            = aws_security_group.web.id
  referenced_security_group_id = aws_security_group.bastion.id
  ip_protocol                  = "tcp"
  from_port                    = 22
  to_port                      = 22
}

resource "aws_vpc_security_group_egress_rule" "web" {
  security_group_id = aws_security_group.web.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

#---------------------------------#
# DB
#---------------------------------#
