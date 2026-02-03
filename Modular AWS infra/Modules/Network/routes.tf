#Only one public route is required as the IGW is a regional service.

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.internet.id
  route {
    cidr_block = var.cidr_map.anywhere
    gateway_id = aws_internet_gateway.internet_igw.id
  }
}

#Two route tables are required for the private subnets as there are two NAT gateways. 

#Route table for the subnet in az1
resource "aws_route_table" "first_private_route" {
  vpc_id = aws_vpc.internet.id
  route {
    cidr_block     = var.cidr_map.anywhere
    nat_gateway_id = aws_nat_gateway.NAT_az1.id
  }
}
#Route table for the subnet in az2
resource "aws_route_table" "second_private_route" {
  vpc_id = aws_vpc.internet.id
  route {
    cidr_block     = var.cidr_map.anywhere
    nat_gateway_id = aws_nat_gateway.NAT_az2.id
  }
}

#Route association table for first_public_subnet
resource "aws_route_table_association" "public_rta_1" {
  subnet_id      = aws_subnet.first_public_subnet.id
  route_table_id = aws_route_table.public_route.id
}
#Route association table for second_public_subnet
resource "aws_route_table_association" "public_rta_2" {
  subnet_id      = aws_subnet.second_public_subnet.id
  route_table_id = aws_route_table.public_route.id
}
#Route association table for first_private_subnet
resource "aws_route_table_association" "private_rta_1" {
  subnet_id      = aws_subnet.first_private_subnet.id
  route_table_id = aws_route_table.first_private_route.id
}
#Route association table for second_private_subnet
resource "aws_route_table_association" "private_rta_2" {
  subnet_id      = aws_subnet.second_private_subnet.id
  route_table_id = aws_route_table.second_private_route.id
}
