terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    # ${Region}/${Environment}/${Resource}/terraform.tfstate
    key = "ap-northeast-1/stage/security-groups/terraform.tfstate"
  }
}
