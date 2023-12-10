# Create VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_configs.cidr_block
  instance_tenancy     = var.vpc_configs.instance_tenancy
  enable_dns_hostnames = var.vpc_configs.enable_dns_hostnames

  tags = {
    Name = "dev-vpc"
  }
}

# Create Internet Gateway and Attach it to a VPC
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "dev-gateway"
  }
}

# Create Public Subnets
resource "aws_subnet" "public" {
  for_each                = var.public_subnet_configs
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch

  tags = {
    Name = each.value.Name
  }
}

# Create Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.public_route_table_configs.cidr_block
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = var.public_route_table_configs.Name
  }
}

# Associate the public subnets with the public route table
resource "aws_route_table_association" "public" {
  for_each       = var.public_subnet_configs
  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public.id
}

# Create Private Subnets
resource "aws_subnet" "private" {
  for_each          = var.private_subnet_configs
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name = each.value.Name
  }
}