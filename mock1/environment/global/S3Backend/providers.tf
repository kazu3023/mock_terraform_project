provider "aws" {
  region = "ap-northeast-1"
  alias  = "primary"
}
provider "aws" {
  region = "ap-northeast-3"
  alias  = "secondary"
}
provider "aws" {
  region = "us-east-1"
  alias  = "global"
}
