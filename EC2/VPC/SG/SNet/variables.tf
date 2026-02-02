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
