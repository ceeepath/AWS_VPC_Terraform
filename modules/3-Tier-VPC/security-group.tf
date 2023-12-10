# Create ALB Security Group
resource "aws_security_group" "alb" {
  name        = var.security_groups_details.name.alb
  description = var.security_groups_details.description.alb
  vpc_id      = aws_vpc.main.id

  # Use dynamic block to create ingress rules from the list
  dynamic "ingress" {
    for_each = local.alb_ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  # Use dynamic block to create egress rule from the object
  dynamic "egress" {
    for_each = local.egress_rule
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = var.security_groups_details.name.alb
  }
}

# Create SSH Security Group
resource "aws_security_group" "ssh" {
  name        = var.security_groups_details.name.ssh
  vpc_id      = aws_vpc.main.id
  description = var.security_groups_details.name.ssh

  # Use dynamic block to create ingress rules from the list
  dynamic "ingress" {
    for_each = local.ssh_ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  # Use dynamic block to create egress rule from the object
  dynamic "egress" {
    for_each = local.egress_rule
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = var.security_groups_details.name.ssh
  }
}

# Create Web Server Security Group
resource "aws_security_group" "web" {
  name        = var.security_groups_details.name.web
  vpc_id      = aws_vpc.main.id
  description = var.security_groups_details.name.web

  # Use dynamic block to create ingress rules from the list
  dynamic "ingress" {
    for_each = local.web_ingress_rules
    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      security_groups = ingress.value.security_groups
    }
  }

  # Use dynamic block to create egress rule from the object
  dynamic "egress" {
    for_each = local.egress_rule
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = var.security_groups_details.name.web
  }

  depends_on = [aws_security_group.alb, aws_security_group.ssh]
}