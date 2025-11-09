resource "aws_s3_bucket" "terraform_tfstate" {
  bucket = var.bucket_name

  #  誤削除防止
  lifecycle {
    prevent_destroy = true
  }
}

# バージョニング有効化
resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}

# サーバーサイド暗号化
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform_tfstate.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# 全てのパブリックアクセスをブロック
resource "aws_s3_bucket_public_access_block" "prohibit_all_public_access" {
  bucket                  = aws_s3_bucket.terraform_tfstate.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}