variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"

}
variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "terraform VPC"

}

variable "subnet_cidr" {
  description = "The CIDR block for the Subnet"
  type        = string
  default     = "10.0.0.0/24"

}

variable "availability_zone" {
  description = "The availability zone for the Subnet"
  type        = string
  default     = "us-east-1"

}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
  default     = "terra-sub-pub-1"
}

variable "igw_name" {
  description = "The name of the Internet Gateway"
  type        = string
  default     = "myigw"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "my-terraform-bucket-12345"

}
variable "instance_type" {
  description = "The type of instance to create"
  default     = "t2.micro"

}

variable "ami_id" {
  description = "The AMI ID for the instance"
  default     = "ami-0532be01f26a3de55" #This is the default amazon linux 2 ami in us-east 1

}

variable "instance_name" {
  description = "The name tag for the instance"
  default     = "my-instance"

}