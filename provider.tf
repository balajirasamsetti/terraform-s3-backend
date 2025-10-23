terraform {
  backend "s3" {
    bucket         = var.state_bucket_name
    key            = var.state_key
    region         = var.aws_region
    dynamodb_table = var.lock_table_name
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}
