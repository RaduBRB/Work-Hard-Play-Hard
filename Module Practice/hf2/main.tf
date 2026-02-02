# In this block I Specify the required Terraform version and AWS provider details
#In this block I Configure the S3 backend for storing the Terraform state file including bucket name, key, region, and encryption settings.
#This is important for collaboration and state management in Terraform.
terraform {
  required_version = ">= 1.5.0"
}

# providers.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.0.0"
    }
  }
}

# backend.tf
terraform {
  backend "s3" {
    bucket  = "hands-on-terraform-bucket-11937"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

# In this block I Configure the AWS provider with the specified region
provider "aws" {
  region = "us-east-1"
}

#In this module block i reference the EC2 module located in the Modules/ec2 directory
module "ec2_instance" {
  source = "./Modules/ec2"
}
#In this module block i reference the S3 module located in the Modules/s3 directory
module "s3_bucket" {
  source = "./Modules/s3"
}
#In this module block i reference the VPC module located in the Modules/vpc directory
module "VPC" {
  source = "./Modules/vpc"
}
