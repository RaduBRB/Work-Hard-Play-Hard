variable "cidr_map" {
  type = map(string)
  default = {
    vpc      = "10.0.0.0/16"
    public1  = "10.0.1.0/24"
    public2  = "10.0.2.0/24"
    private1 = "10.0.3.0/24"
    private2 = "10.0.4.0/24"
    anywhere = "0.0.0.0/0"
  }
}

variable "location" {
  type = map(string)
  default = {
    az1    = "us-east-1a"
    az2    = "us-east-1b"
    region = "us-east-1"
  }
}
