module "terraform_backend_s3_primary" {
  source      = "../../../module/global/S3Backend"
  bucket_name = "mock1-terraform-backend-ap-northeast-1"
  providers = {
    aws = aws.primary
  }
}

module "terraform_backend_s3_secondary" {
  source      = "../../../module/global/S3Backend"
  bucket_name = "mock1-terraform-backend-ap-northeast-3"
  providers = {
    aws = aws.secondary
  }
}

module "terraform_backend_s3_global" {
  source      = "../../../module/global/S3Backend"
  bucket_name = "mock1-terraform-backend-global"
  providers = {
    aws = aws.global
  }
}
