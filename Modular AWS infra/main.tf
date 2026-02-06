
module "network" {
  source = "./modules/network"

  cidr_map = var.cidr_map
  location = var.location
}