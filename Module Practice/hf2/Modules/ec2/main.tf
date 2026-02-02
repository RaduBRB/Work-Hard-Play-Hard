resource "aws_instance" "this" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = aws_subnet.this.id
    vpc_security_group_ids = aws_security_group.terra-sg.ids

    tags = {
      Name = var.instance_name
    }
  
}
