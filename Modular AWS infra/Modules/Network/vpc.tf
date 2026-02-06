resource "aws_vpc" "internet" {
  cidr_block = var.cidr_map["vpc"]
}
