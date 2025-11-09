variable "system_name" {
  type = string
}
variable "region" {
  type = string
}
variable "env" {
  type = string
}
variable "bucket_name" {
  type = string
}
variable "tfstate_key_vpc" {
  type = string
}
variable "tfstate_key_sg" {
  type = string
}
variable "instance_type_bastion" {
  type = string
  default = "t3.medium"
}
variable "instance_type_web" {
  type = string
  default = "t3.medium"
}