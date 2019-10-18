# VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags       = merge(var.tags, map("Name", join("-",[var.name["Organisation"], var.name["OrganisationUnit"], "all", var.name["Environment"], "all"])))
}

# IG
resource "aws_internet_gateway" "public" {
  vpc_id = aws_vpc.main.id
  tags   = merge(var.tags, map("Name", join("-",[var.name["Organisation"], var.name["OrganisationUnit"], "all", var.name["Environment"], "pub"])))
}

# Route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public.id
  }
  tags   = merge(var.tags, map("Name", join("-",[var.name["Organisation"], var.name["OrganisationUnit"], "all", var.name["Environment"], "pub"])))
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags   = merge(var.tags, map("Name", join("-",[var.name["Organisation"], var.name["OrganisationUnit"], "all", var.name["Environment"], "pri"])))
}

# Subnet
resource "aws_subnet" "public" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_cidr[count.index]
  availability_zone = var.availability_zones[count.index % length(var.availability_zones)]
  tags              = merge(var.tags, map("Name", join("-",[var.name["Organisation"], var.name["OrganisationUnit"], "all", var.name["Environment"], "pub", "0${count.index+1}"])))
}

resource "aws_subnet" "private" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_cidr[count.index]
  availability_zone = var.availability_zones[count.index % length(var.availability_zones)]
  tags              = merge(var.tags, map("Name", join("-",[var.name["Organisation"], var.name["OrganisationUnit"], "all", var.name["Environment"], "pri", "0${count.index+1}"])))
}

# NACL
resource "aws_network_acl" "public" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.public.*.id
  egress {
    protocol   = "all"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  ingress {
    protocol   = "all"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  tags = merge(var.tags, map("Name", join("-",[var.name["Organisation"], var.name["OrganisationUnit"], "all", var.name["Environment"], "pub"])))
}

resource "aws_network_acl" "private" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.private.*.id
  egress {
    protocol   = "all"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  ingress {
    protocol   = "all"
    rule_no    = 200
    action     = "allow"
    cidr_block = var.vpc_cidr
    from_port  = 0
    to_port    = 0
  }
  tags = merge(var.tags, map("Name", join("-",[var.name["Organisation"], var.name["OrganisationUnit"], "all", var.name["Environment"], "pri"])))
}

# Subnet <-->  Route table
resource "aws_route_table_association" "public" {
  count          = length(var.availability_zones)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.availability_zones)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}

# VPC Endpoint - S3 Gateway
resource "aws_vpc_endpoint" "s3" {
  vpc_id          = aws_vpc.main.id
  service_name    = "com.amazonaws.${var.region}.s3"
  route_table_ids = ["${aws_route_table.public.id}","${aws_route_table.private.id}"]
  tags            = merge(var.tags, map("Name", join("-",[var.name["Organisation"], var.name["OrganisationUnit"], "all", var.name["Environment"], "bs3"])))
}
