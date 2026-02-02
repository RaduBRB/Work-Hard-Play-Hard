variable "instance_type" {
    description = "The type of instance to create"
    default = "t2.micro"
  
}

variable "ami_id" {
    description = "The AMI ID for the instance"
    default = "ami-0532be01f26a3de55" #This is the default amazon linux 2 ami in us-east 1
  
}

variable "instance_name" {
    description = "The name tag for the instance"
    default = "my-instance"
  
}