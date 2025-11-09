terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    # ${Region}/${Environment}/${Resource}
    key = "global/s3backend/terraform.tfstate"
  }
}
