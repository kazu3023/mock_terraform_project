#---------------------------------#
# VPC
#---------------------------------#
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.system_name}-${var.env}-vpc"
  cidr = "10.0.100.0/24"

  azs             = ["${var.region}a", "${var.region}c"]
  public_subnets  = ["10.0.100.0/28", "10.0.100.16/28"]
  private_subnets = ["10.0.100.32/28", "10.0.100.48/28"]
  intra_subnets   = ["10.0.100.64/28", "10.0.100.80/28"]

  # enable_nat_gateway     = true
  # single_nat_gateway     = true
  # one_nat_gateway_per_az = true

  enable_dns_hostnames = true
  enable_dns_support   = true
}

#============================================
# VPC Flowlog
#============================================
# #---------------------------------#
# # FlowLog
# #---------------------------------#
# module "flow_log" {
#   source = "terraform-aws-modules/vpc/aws//modules/flow-log"

#   vpc_id = module.vpc.vpc_id

#   log_destination_type = "s3"
#   log_destination      = aws_s3_bucket.flow_logs.arn

#   # オプション
#   traffic_type                 = "ALL"  # ALL, ACCEPT, REJECT
#   max_aggregation_interval     = 60     # 60 or 600秒
# }

# #---------------------------------#
# # FlowLog用S3バケット
# #---------------------------------#
# resource "aws_s3_bucket" "flow_logs" {
#   bucket = "${var.system_name}-${var.env}-vpc-flow-logs"
# }

# resource "aws_s3_bucket_lifecycle_configuration" "flow_logs" {
#   bucket = aws_s3_bucket.flow_logs.id

#   rule {
#     id     = "delete-old-logs"
#     status = "Enabled"

#     expiration {
#       days = 30  # 30日後に削除
#     }
#   }
# }

# #---------------------------------#
# # S3バケットポリシー（重要！）
# #---------------------------------#
# resource "aws_s3_bucket_policy" "flow_logs" {
#   bucket = aws_s3_bucket.flow_logs.id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Sid    = "AWSLogDeliveryWrite"
#         Effect = "Allow"
#         Principal = {
#           Service = "delivery.logs.amazonaws.com"
#         }
#         Action = [
#           "s3:PutObject"
#         ]
#         Resource = "${aws_s3_bucket.flow_logs.arn}/*"
#         Condition = {
#           StringEquals = {
#             "s3:x-amz-acl" = "bucket-owner-full-control"
#           }
#         }
#       },
#       {
#         Sid    = "AWSLogDeliveryAclCheck"
#         Effect = "Allow"
#         Principal = {
#           Service = "delivery.logs.amazonaws.com"
#         }
#         Action = "s3:GetBucketAcl"
#         Resource = aws_s3_bucket.flow_logs.arn
#       }
#     ]
#   })
# }
