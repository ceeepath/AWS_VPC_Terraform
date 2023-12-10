variable "vpc_configs" {
  type = object({
    cidr_block           = string
    instance_tenancy     = string
    enable_dns_hostnames = bool
  })
}

variable "public_subnet_configs" {
  type = map(object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
    Name                    = string
  }))
}

variable "public_route_table_configs" {
  type = map(string)
}

variable "private_subnet_configs" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
    Name              = string
  }))
}

variable "nat_gateway_configs" {
  type = map(map(string))
}

variable "prt_association_configs" {
  type = map(set(string))
}

variable "security_groups_details" {
  type = map(map(string))
}