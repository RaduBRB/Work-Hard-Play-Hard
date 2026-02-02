resource "aws_vpc" "this" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = var.vpc_name
    }
  
}

resource "aws_subnet" "this" {
    cidr_block = var.subnet_cidr
    vpc_id     = aws_vpc.this.id
    availability_zone = var.availability_zone
    map_public_ip_on_launch = true
    tags = {
        Name = var.subnet_name
    }
  
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
    tags = {
        Name = var.igw_name
    }
}

resource "aws_security_group" "terra-sg" {
    name        = "terra-sg"
    description = "Security group for Terraform EC2 instance"
    vpc_id      = aws_vpc.this.id
    
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

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.this.id

    tags = {
        Name = "public-rt"
    }
  
}
resource "aws_route" "terra-route" {
    route_table_id         = aws_vpc.this.main_route_table_id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.this.id   
  
}

resource "aws_route_table_association" "public_rt_assoc" {
    subnet_id      = aws_subnet.this.id
    route_table_id = aws_route_table.public_rt.id
  
}