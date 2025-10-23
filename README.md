# Terraform AWS EC2 with S3 Backend & DynamoDB Locking

![Terraform](https://img.shields.io/badge/Terraform-v1.5-blue?logo=terraform)
![AWS](https://img.shields.io/badge/AWS-Cloud-orange?logo=amazon-aws)

This repository provisions an AWS EC2 instance using Terraform, with:

- Remote state management in S3  
- State locking using DynamoDB  
- Deployment inside a custom VPC subnet                         
- Fully parameterized via variables  

---

## Features

- Launch EC2 instance with custom AMI, instance type, key pair, and tags
- Supports remote state management in S3
- Prevents concurrent Terraform runs via DynamoDB locking
- Customizable for different environments

---

## Prerequisites

- Terraform >= 1.5.x
- AWS CLI configured
- Existing AWS key pair
- Custom VPC & Subnet
- Pre-created **S3 bucket** and DynamoDB table for state backend
- This project has been successfully tested in [GitHub Codespaces](https://github.com/features/codespaces).

---

## Quick Start

# Clone the repo
git clone https://github.com/balajirasamsetti/terraform-s3-backend.git
cd terraform-s3-backend

# Initialize Terraform backend
terraform init -reconfigure

# Validate configuration
terraform validate

# Preview resources to be created
terraform plan

# Apply configuration
terraform apply

Note on Terraform Backend Variables

You cannot use standard Terraform variables (var.*) directly in the backend block.

Backend configuration must use literal values or be provided manually during terraform init.

This is because Terraform configures the backend before it loads variables.

Example (generalized):

terraform init \
  -backend-config="bucket=<YOUR_S3_BUCKET>" \
  -backend-config="key=<PATH/TO/STATE_FILE>" \
  -backend-config="region=<AWS_REGION>" \
  -backend-config="dynamodb_table=<DYNAMODB_LOCK_TABLE>"


Explanation of parameters:

Parameter	Description
bucket	Name of the S3 bucket to store Terraform state
key	Path and filename for the state file inside the bucket
region	AWS region where the S3 bucket and DynamoDB table exist
dynamodb_table	DynamoDB table used to lock state during Terraform runs

# Project Challenges / Issues Encountered

During this project, several challenges were encountered:

No default subnet in AWS account

Error: No subnets found for the default VPC

Solution: Created a custom VPC (TerraformVPC) and subnet in the AWS console and specified it in subnet_id.

Using variables in the S3 backend

Error: Variables may not be used here

Solution: Backend configuration must use literal values or -backend-config on terraform init.

State management and locking

Needed an S3 bucket for state and DynamoDB table for locks to prevent concurrent runs.

Solution: Created a separate backend/ folder with Terraform scripts to provision these resources first.

Keeping local workspace in sync with GitHub

Subnet updates were not reflected locally.

Solution: Pulled latest changes using git pull to sync terraform.tfvars and configuration files.

Ensuring internet access for EC2

Public IP assignment requires route to an Internet Gateway in custom subnet.

Solution: Updated the subnet route table and attached an Internet Gateway.
