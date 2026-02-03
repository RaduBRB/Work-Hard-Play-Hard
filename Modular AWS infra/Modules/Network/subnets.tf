resource "aws_subnet" "first_public_subnet" {
    vpc_id = aws_vpc.internet.id
    cidr_block = var.cidr_map.public1
    availability_zone       = var.location.az1
    map_public_ip_on_launch = true

  
}

resource "aws_subnet" "second_public_subnet" {
    vpc_id = aws_vpc.internet.id
    cidr_block = var.cidr_map.public2
    availability_zone       = var.location.az2
    map_public_ip_on_launch = true 
}

resource "aws_subnet" "first_private_subnet" {
    vpc_id = aws_vpc.internet.id
    cidr_block = var.cidr_map.private1
    availability_zone       = var.location.az1
  
}
resource "aws_subnet" "second_private_subnet" {
    vpc_id = aws_vpc.internet.id
    cidr_block = var.cidr_map.private2
    availability_zone       = var.location.az2
  
}