# And this is the first mistake I've done and learned from. In my opinion i've done these variables right but the reality is the fact that I hardcoded them inside the Network Module. 
#The ideal situation would have been the following in the root main.tf 
# module "network" {
#   source = "./modules/network"

#   vpc_cidr             = "10.0.0.0/16"
#   public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
#   private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
# }


variable "cidr_map" {
    type = map(string)
    default = {
      vpc = "10.0.0.0/16"
      public1 = "10.0.1.0/24"
      public2 = "10.0.2.0/24"
      private1 = "10.0.3.0/24"
      private2 = "10.0.4.0/24"
      anywhere = "0.0.0.0/0"
    }
  
}

variable "location" {
    type = map(string)
    default = {
      az1 = "us-east-1a"
      az2 = "us-east-1b"
      region = "us-east-1"
    }
  
}