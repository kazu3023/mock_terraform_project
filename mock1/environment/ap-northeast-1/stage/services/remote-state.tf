#---------------------------------#
# RemoteState
#---------------------------------#
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = var.bucket_name
    key    = var.tfstate_key_vpc
    region = var.region
  }
}
data "terraform_remote_state" "sg" {
  backend = "s3"
  config = {
    bucket = var.bucket_name
    key    = var.tfstate_key_sg
    region = var.region
  }
}
