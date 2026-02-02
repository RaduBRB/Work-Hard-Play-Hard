variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"

}

variable "az" {
  description = "The availability zone to deploy resources in"
  type        = string
  default     = "us-east-1a"

}

variable "cidr_blockVPC" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"

}

variable "cidr_blockPublic" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"

}

variable "cidr_blockPrivate" {
  description = "The CIDR block for the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}