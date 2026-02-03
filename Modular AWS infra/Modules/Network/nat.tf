# I had to create two NAT Gateways as AWS does not recommend Cross-AZ due to extra charges.

#NAT for availablity zone one: us-east-1a allocated top the public subnet in order to have access to the internet.
resource "aws_nat_gateway" "NAT_az1" {
allocation_id = aws_eip.NAT_EIP_az1.id
subnet_id     = aws_subnet.first_public_subnet.id
}

#EIP stands for elastic IP which is static public IP. This is a must for a NAT Gateway as this requires an IP address, without one it would not be able to reach the internet.
resource "aws_eip" "NAT_EIP_az1" {
domain = "vpc"
tags = {
     Name = "Internet_NAT_IP_az1"
  }
}

#NAT for availablity zone two: us-east-1b allocated top the public subnet in order to have access to the internet.
resource "aws_nat_gateway" "NAT_az2" {
allocation_id = aws_eip.NAT_EIP_az2.id
subnet_id     = aws_subnet.second_public_subnet.id
}

resource "aws_eip" "NAT_EIP_az2" {
domain = "vpc"
tags = {
     Name = "Internet_NAT_IP_az2"
  }
}
  