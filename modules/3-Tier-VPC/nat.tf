# Create Elastic IP
resource "aws_eip" "public" {
  for_each = var.nat_gateway_configs.eip_name
  domain   = local.eip_domain

  tags = {
    Name = each.value
  }

  depends_on = [aws_internet_gateway.main]
}

# Create NAT Gateway
resource "aws_nat_gateway" "public" {
  for_each      = var.nat_gateway_configs.nat_name
  allocation_id = aws_eip.public[each.key].id
  subnet_id     = aws_subnet.public[each.key].id

  tags = {
    Name = each.value
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main]
}

# Create Private Route Tables
resource "aws_route_table" "private" {
  for_each = var.nat_gateway_configs.prt_name
  vpc_id   = aws_vpc.main.id

  route {
    cidr_block     = local.internet_cidr
    nat_gateway_id = aws_nat_gateway.public[each.key].id
  }

  tags = {
    Name = each.value
  }

  depends_on = [aws_nat_gateway.public]
}


# Associate the private subnets with the private route tables
resource "aws_route_table_association" "private_1" {
  for_each       = var.prt_association_configs.az1
  subnet_id      = aws_subnet.private[each.value].id
  route_table_id = aws_route_table.private["az1"].id
}

resource "aws_route_table_association" "private_2" {
  for_each       = var.prt_association_configs.az2
  subnet_id      = aws_subnet.private[each.value].id
  route_table_id = aws_route_table.private["az2"].id
}