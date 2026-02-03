provider "aws" {
  region = "us-east-1"

}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.0.0"
    }
  }
}
#1. created a vpc with a specified cidr block from variables
resource "aws_vpc" "terravpc" {                                                                               
  cidr_block = var.cidr_blockVPC
  tags = {
    Name = "TerraVPC"
  }

}
 #2 Created a public subnet with auto assign public ip so instances can talk to the internet and recevie traffic                                                                     
resource "aws_subnet" "terrasubnet1" {
  vpc_id                  = aws_vpc.terravpc.id
  cidr_block              = var.cidr_blockPublic
  availability_zone       = var.az
  map_public_ip_on_launch = true
  tags = {
    Name = "terrapublicsubnet"
  }
}
# Create Private Subnet                                                
resource "aws_subnet" "terrasubnet2" {
  vpc_id            = aws_vpc.terravpc.id
  cidr_block        = var.cidr_blockPrivate
  availability_zone = var.az

  tags = {
    Name = "terraprivatesubnet"
  }
}
# Create Internet Gateway and attached it to the VPC.
resource "aws_internet_gateway" "TerraIGW" {
  vpc_id = aws_vpc.terravpc.id

  tags = {
    Name = "TerraIGW"
  }

}
# Internet Gateway Route Table for Public Subnet 
resource "aws_route_table" "TerraPublicRT" {
  vpc_id = aws_vpc.terravpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.TerraIGW.id
  }
}

# Associate Public Subnet with Internet Gateway Route Table.A subnet is public when its route table has a default route (0.0.0.0/0) to an Internet Gateway.
resource "aws_route_table_association" "publicsubnetIGW" {
  subnet_id      = aws_subnet.terrasubnet1.id
  route_table_id = aws_route_table.TerraPublicRT.id
}


# NAT Gateway for Private Subnet
resource "aws_nat_gateway" "TerraNAT" {
  allocation_id = aws_eip.TerraNATEIP.id
  subnet_id     = aws_subnet.terrasubnet1.id

  tags = {
    Name = "TerraNAT"
  }
}
# Elastic IP for NAT Gateway
resource "aws_eip" "TerraNATEIP" {
  domain = "vpc"

  tags = {
    Name = "TerraNATEIP"
  }
  
}
# This block creates a route table for the private subnet that routes traffic through the NAT gateway   

resource "aws_route_table" "TerraPrivateRT" {
  vpc_id = aws_vpc.terravpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.TerraNAT.id
  }
}
# Associate Private Subnet with NAT Gateway Route Table. A subnet is private when its route table has a default route .
resource "aws_route_table_association" "privatesubnetNAT" {
  subnet_id      = aws_subnet.terrasubnet2.id
  route_table_id = aws_route_table.TerraPrivateRT.id
}
