terraform {
  required_providers {
    aws ={
        source = "hashicorp/aws"
        version = "6.0.0-beta2"
    }
    random = {
        source = "hashicorp/random"
        version = "3.7.2"
    }
  }
}

resource "random_id" "s3_suffix" {
    byte_length = 4
  
}
resource "aws_s3_bucket" "s3" {
  bucket = "ps-tf-bucket-${terraform.workspace}-${random_id.s3_suffix.hex}"
  tags = {
    ManagedBy = "terraform"
    Environmnet = terraform.workspace
  }
}

resource "aws_s3_bucket" "s3_existing" {
    bucket = "ps-tf-existing-bucket-3a5303f0"
    website {
      error_document = "index.html"
      index_document = "index.html"
    }
    tags = {
      ManagedBy = "terraform"
    }
}