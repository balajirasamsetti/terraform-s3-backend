variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
}

variable "state_bucket_name" {
  description = "S3 bucket for Terraform state"
  type        = string
}

variable "lock_table_name" {
  description = "DynamoDB table for locking"
  type        = string
}

variable "state_key" {
  description = "S3 key path for Terraform state file"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where EC2 will be launched"
  type        = string
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "key_pair_name" {
  description = "Name of the existing EC2 key pair"
  type        = string
}

variable "instance_name" {
  description = "Name tag for EC2 instance"
  type        = string
}

variable "environment" {
  description = "Environment name (dev/test/prod)"
  type        = string
}
