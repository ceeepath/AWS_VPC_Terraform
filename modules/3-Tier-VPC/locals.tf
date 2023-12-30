locals {
  eip_domain    = "vpc"
  internet_cidr = "0.0.0.0/0"
}

# Define the list of ingress & egress rules for each security group
locals {
  alb_ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  ssh_ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  web_ingress_rules = [
    {
      from_port       = 80
      to_port         = 80
      protocol        = "tcp"
      security_groups = [aws_security_group.alb.id]
    },
    {
      from_port       = 443
      to_port         = 443
      protocol        = "tcp"
      security_groups = [aws_security_group.alb.id]
    },
    {
      from_port       = 22
      to_port         = 22
      protocol        = "tcp"
      security_groups = [aws_security_group.ssh.id]
    }
  ]

  db_ingress_rules = [
    {
      from_port       = 3306
      to_port         = 3306
      protocol        = "tcp"
      security_groups = [aws_security_group.web.id]
    }
  ]

  dummy_ingress_rules = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = [var.public_subnet_configs.az1.cidr_block]
    }
  ]

  # efs_ingress_rules = [
  #   {
  #     from_port       = 2049
  #     to_port         = 2049
  #     protocol        = "tcp"
  #     security_groups = [aws_security_group.web.id]
  #     self            = true
  #   },
  #   {
  #     from_port       = 22
  #     to_port         = 22
  #     protocol        = "tcp"
  #     security_groups = [aws_security_group.ssh.id]
  #     self            = false
  #   }
  # ]

  egress_rule = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}