output "public_subnet_ids" {
    description = "This will list the name of the public subnets"
    value = [
        aws_subnet.first_public_subnet.id ,
        aws_subnet.second_public_subnet.id
    ]
}

output "private_subnet_ids" {
    description = "This will list the name of the private subnets"
    value = [
        aws_subnet.first_private_subnet.id , 
        aws_subnet.second_private_subnet.id
    ]
  
}

output "VPC_ID" {
    description = "This will list the name of the VPC"
    value = aws_vpc.internet.id
  
}

