provider "aws" {
    region = "us-east-1"
  
}

# This command creates a VPC with a CIDR block.
resource "aws_vpc" "my_vpc_day1" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "TerraVPC"
    }
}
# This command creates a subnet within the VPC.
resource "aws_subnet" "example_subnet" {
    vpc_id            = aws_vpc.my_vpc_day1.id
    cidr_block        = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    
    tags = {
        Name = "terranet"
    }
  
}


resource "aws_instance" "example" {
    ami          = "ami-0532be01f26a3de55" # Amazon Linux 2 AMI
    instance_type = "t2.micro"
    subnet_id     = aws_subnet.example_subnet.id # This command links the subnet to the instance.
    vpc_security_group_ids = [aws_security_group.instance.id] # This command links the security group to the instance. 
    associate_public_ip_address = true # Ensure the instance gets a public IP address and is accessible over the internet.

    tags = {
        Name = "TerraInstance"
    }

# Thi s block configures the root block device for the instance.
root_block_device {
  volume_type = "gp2"
  volume_size = 10
}

}
# This command creates a security group for the instance.
resource "aws_security_group" "instance" {
    name = "instance-sg"
    description = "Security group for EC2 instance-example"
    vpc_id = aws_vpc.my_vpc_day1.id
    
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        }
  
}
# This command creates an S3 bucket.
resource "aws_s3_bucket" "mys3bucket_day1" {
    bucket = "terras3bucketday1-unique-name-202406" 
    tags = {
        Name        = "TerraS3Bucket"
        Environment = "Dev"
    }
  
}
# This block configures the backend to use S3 for storing the Terraform state file.
terraform {
 backend "s3" {
    bucket = "terras3bucketday1-unique-name-202406"
    key    = "terras3bucketday1-unique-name-202406/terraform.tfstate"
    region = "us-east-1"
    
  }
}