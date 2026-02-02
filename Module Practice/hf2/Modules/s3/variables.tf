variable "bucket_name" {
    description = "The name of the S3 bucket"
    type        = string
    default     = "my-terraform-bucket-4141992"
  
}

variable "region" {
  
    description = "The AWS region where the S3 bucket will be created"
    type        = string
    default     = "us-east-1"
}