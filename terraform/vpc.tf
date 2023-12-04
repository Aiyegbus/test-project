data "aws_availability_zones" "ec2_az" {
  state = "available"
  filter {
    name   = "opt-in-status"
    values = ("opt-in-not-required")
  }
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "main_gw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_subnet" "main_sub" {
  vpc_id                  = aws_vpc.main.id
  count                   = var.subnet_count
  cidr_block              = cidrsubnet(var.vpc_cidr, 2, count.index)
  availability_zone       = data.aws_availability_zones.ec2_az.names[count.index % var.az_count]
  map_public_ip_on_launch = true
}

resource "aws_route_table" "main_rt" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "main_route" {
  route_table_id         = aws_route_table.main_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main_gw.id
}

resource "aws_route_table_association" "main_rt_ass" {
  count          = var.subnet_count
  subnet_id      = element(aws_subnet.main_sub.*.id, count.index)
  route_table_id = aws_route_table.main_rt.id
}
