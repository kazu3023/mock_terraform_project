output "sg_bastion" {
  value = aws_security_group.bastion.id
}
output "sg_web" {
  value = aws_security_group.web.id
}