resource "aws_vpc" "TerraVPC" {
  cidr_block = "10.0.0.0/16"

}

#As I am about to create an ASG and Load Balancer, both require at least two subnets to be in different AZ. 
#This gives me Multi-AZ load balancing, Multi-AZ Ec2 placement and Multi-AZ fault tolerance.

resource "aws_subnet" "TerraSubnet1" {
  vpc_id                  = aws_vpc.TerraVPC.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

}

resource "aws_subnet" "TerraSubnet2" {
  vpc_id                  = aws_vpc.TerraVPC.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "Terra_IGW" {
  vpc_id = aws_vpc.TerraVPC.id
}

resource "aws_route_table" "Terra_RT" {
  vpc_id = aws_vpc.TerraVPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Terra_IGW.id
  }
}

resource "aws_route_table_association" "public_assoc1" {
  subnet_id      = aws_subnet.TerraSubnet1.id
  route_table_id = aws_route_table.Terra_RT.id
}

resource "aws_route_table_association" "public_assoc2" {
  subnet_id      = aws_subnet.TerraSubnet2.id
  route_table_id = aws_route_table.Terra_RT.id
}

resource "aws_security_group" "sg_alb" {
  name        = "sg_alb"
  description = "Security Group for ALB"
  vpc_id      = aws_vpc.TerraVPC.id
}
#This allows everypublic address to be able to reach out the ALB through port 80(http). Than the ALB will communicate with the EC2.
#Very important to mention that the EC2 does not communicate with the alb through port 80, the EC2 requires internet connection only to be able to run the commands when launched by ASG.
resource "aws_vpc_security_group_ingress_rule" "alb_http_in" {
  security_group_id = aws_security_group.sg_alb.id
  description       = "Security gorup for ALB"
  #Inbound: allow HTTP from anywhere
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
}

resource "aws_vpc_security_group_egress_rule" "alb_out" {
  security_group_id = aws_security_group.sg_alb.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}


resource "aws_security_group" "sg_ec2" {
  name        = "sg_ec2"
  description = "Security group for EC2"
  vpc_id      = aws_vpc.TerraVPC.id
}

resource "aws_vpc_security_group_ingress_rule" "SG_EC2" {
  security_group_id            = aws_security_group.sg_ec2.id
  referenced_security_group_id = aws_security_group.sg_alb.id
  description                  = "Security gorup for Ec2 instances"
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "SG_EC2_I" {
  security_group_id            = aws_security_group.sg_ec2.id
  
  description                  = "Security gorup for Ec2 instances"
  ip_protocol                  = "-1"
  cidr_ipv4 = "0.0.0.0/0"

}

resource "aws_vpc_security_group_ingress_rule" "sg_ec2_ssh" {
  security_group_id = aws_security_group.sg_ec2.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = "0.0.0.0/0" #This is something should never be done, but was only for testing purposes
}
