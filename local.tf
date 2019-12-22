# ACL rules for public subnet
locals {
  # ACL rules for public subnet - Inbound rules
  public_acl_ingress = [
    {
      rule_no    = 100
      protocol   = "tcp"
      action     = "allow"
      cidr_block = "${chomp(data.http.myip.body)}/32"
      from_port  = 22
      to_port    = 22
    },
    {
      rule_no    = 110
      protocol   = "tcp"
      action     = "allow"
      cidr_block = "0.0.0.0/0" //var.vpc_cidr
      from_port  = 80
      to_port    = 80
    },  
    {
      rule_no    = 120
      protocol   = "tcp"
      action     = "allow"
      cidr_block = "0.0.0.0/0" //var.vpc_cidr
      from_port  = 443
      to_port    = 443
    },
    {
      rule_no    = 130
      protocol   = "tcp"
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 1024
      to_port    = 65535
    }
  ]

  # ACL rules for public subnet - Outbound rules
  public_acl_egress = [
    {
      protocol   = "tcp"
      rule_no    = 100
      action     = "allow"
      cidr_block = var.vpc_cidr
      from_port  = 22
      to_port    = 22
    },
    {
      protocol   = "tcp"
      rule_no    = 110
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 80
      to_port    = 80
    },  
    {
      protocol   = "tcp"
      rule_no    = 120
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 443
      to_port    = 443
    },
    {
      protocol   = "tcp"
      rule_no    = 130
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 32768
      to_port    = 65535
    },
    {
      protocol   = "tcp"
      rule_no    = 140
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 1024
      to_port    = 65535
    }
  ] 
}


# ACL rules for private subnet
locals {
  # ACL rules for private subnet - Inbound rules
  private_acl_ingress = [
    {
      protocol   = "tcp"
      rule_no    = 100
      action     = "allow"
      cidr_block = var.vpc_cidr
      from_port  = 22
      to_port    = 22
    },
    {
      protocol   = "tcp"
      rule_no    = 110
      action     = "allow"
      cidr_block = var.vpc_cidr
      from_port  = 80
      to_port    = 80
    },
    {
      protocol   = "tcp"
      rule_no    = 120
      action     = "allow"
      cidr_block = var.vpc_cidr
      from_port  = 443
      to_port    = 443
    },
    {
      protocol   = "tcp"
      rule_no    = 130
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 1024
      to_port    = 65535
    }
  ]

  # ACL rules for private subnet - Outbound rules
  private_acl_egress = [
    {
      protocol   = "tcp"
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 80
      to_port    = 80
    },
    {
      protocol   = "tcp"
      rule_no    = 110
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 443
      to_port    = 443
    },
    {
      protocol   = "tcp"
      rule_no    = 120
      action     = "allow"
      cidr_block = var.vpc_cidr
      from_port  = 32768
      to_port    = 65535
    },
    {
      protocol   = "tcp"
      rule_no    = 130
      action     = "allow"
      cidr_block = var.vpc_cidr
      from_port  = 1024
      to_port    = 65535
    }
  ] 
}
