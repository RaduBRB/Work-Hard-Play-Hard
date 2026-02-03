resource "aws_internet_gateway" "internet_igw" {
  vpc_id = aws_vpc.internet.id
}