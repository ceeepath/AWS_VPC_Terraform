vpc_configs = {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
}

public_subnet_configs = {
  az1 = { cidr_block = "10.0.0.0/24", availability_zone = "us-east-1a", map_public_ip_on_launch = true, Name = "public-subnet-az1" }
  az2 = { cidr_block = "10.0.1.0/24", availability_zone = "us-east-1b", map_public_ip_on_launch = true, Name = "public-subnet-az2" }
}

public_route_table_configs = { cidr_block = "0.0.0.0/0", Name = "public-route-table" }

private_subnet_configs = {
  app-az1  = { cidr_block = "10.0.2.0/24", availability_zone = "us-east-1a", Name = "private-app-subnet-az1" }
  app-az2  = { cidr_block = "10.0.3.0/24", availability_zone = "us-east-1b", Name = "private-app-subnet-az2" }
  data-az1 = { cidr_block = "10.0.4.0/24", availability_zone = "us-east-1a", Name = "private-data-subnet-az1" }
  data-az2 = { cidr_block = "10.0.5.0/24", availability_zone = "us-east-1b", Name = "private-data-subnet-az2" }
}

nat_gateway_configs = {
  nat_name = { az1 = "NAT Gateway AZ1", az2 = "NAT Gateway AZ2" }
  eip_name = { az1 = "az1-eip", az2 = "az2-eip" }
  prt_name = { az1 = "az1-prt", az2 = "az2-prt" }
}

prt_association_configs = {
  az1 = ["app-az1", "data-az1"]
  az2 = ["app-az2", "data-az2"]
}

security_groups_details = {
  name        = { alb = "App-Load-Balancer-SG", ssh = "SSH-SG", web = "Web-Server-SG", db = "Database-Server-SG", efs = "EFS-SG" }
  description = { alb = "Application Load Balancer Security Group", ssh = "SSH Security Group", web = "Web Server Security Group", db = "Database Security Group", efs = "EFS Security Group" }
}