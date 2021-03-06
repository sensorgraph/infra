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
  cidr_block        = cidrsubnet(var.vpc_cidr, 3, count.index)
  availability_zone = var.availability_zones[count.index % length(var.availability_zones)]
  tags              = merge(var.tags, map("Name", join("-",[var.name["Organisation"], var.name["OrganisationUnit"], "all", var.name["Environment"], "pub", "0${count.index+1}"])))
}

resource "aws_subnet" "private" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 3, length(var.availability_zones) + count.index)
  availability_zone = var.availability_zones[count.index % length(var.availability_zones)]
  tags              = merge(var.tags, map("Name", join("-",[var.name["Organisation"], var.name["OrganisationUnit"], "all", var.name["Environment"], "pri", "0${count.index+1}"])))
}

# NACL
resource "aws_network_acl" "public" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.public.*.id

  dynamic "ingress" {
    for_each = local.public_acl_ingress
    content {
      rule_no         = ingress.value.rule_no
      protocol        = ingress.value.protocol
      action          = ingress.value.action
      cidr_block      = ingress.value.cidr_block
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
    }
  }

  dynamic "egress" {
    for_each = local.public_acl_egress
    content {
      rule_no         = egress.value.rule_no
      protocol        = egress.value.protocol
      action          = egress.value.action
      cidr_block      = egress.value.cidr_block
      from_port       = egress.value.from_port
      to_port         = egress.value.to_port
    }
  }

  tags = merge(var.tags, map("Name", join("-",[var.name["Organisation"], var.name["OrganisationUnit"], "all", var.name["Environment"], "pub"])))
}

resource "aws_network_acl" "private" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.private.*.id
  
  dynamic "ingress" {
    for_each = local.private_acl_ingress
    content {
      rule_no         = ingress.value.rule_no
      protocol        = ingress.value.protocol
      action          = ingress.value.action
      cidr_block      = ingress.value.cidr_block
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
    }
  }

  dynamic "egress" {
    for_each = local.private_acl_egress
    content {
      rule_no         = egress.value.rule_no
      protocol        = egress.value.protocol
      action          = egress.value.action
      cidr_block      = egress.value.cidr_block
      from_port       = egress.value.from_port
      to_port         = egress.value.to_port
    }
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

# VPC Endpoint - S3 Gateway
resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id          = aws_vpc.main.id
  service_name    = "com.amazonaws.${var.region}.dynamodb"
  route_table_ids = ["${aws_route_table.public.id}","${aws_route_table.private.id}"]
  tags            = merge(var.tags, map("Name", join("-",[var.name["Organisation"], var.name["OrganisationUnit"], "all", var.name["Environment"], "ddb"])))
}
