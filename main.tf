module "vpc" {
  source                     = "./modules/3-Tier-VPC"
  vpc_configs                = var.vpc_configs
  public_subnet_configs      = var.public_subnet_configs
  public_route_table_configs = var.public_route_table_configs
  private_subnet_configs     = var.private_subnet_configs
  nat_gateway_configs        = var.nat_gateway_configs
  prt_association_configs    = var.prt_association_configs
  security_groups_details    = var.security_groups_details
}