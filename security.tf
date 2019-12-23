# Public LB

resource "aws_security_group" "public_web_lb" {
  name        = "public-web-lb"
  description = "[Terraform] Allow ALL inbound traffic (80, 433)"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "[Terraform] Open HTTP to world"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "[Terraform] Open HTTPS to world"
  }

  tags = merge(var.tags, map("Name", "public-web-lb"))
}

# Private application

resource "aws_security_group" "private_web_app" {
  name        = "private-web-app"
  description = "[Terraform] Allow VPC inbound traffic (80, 433)"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
    description = "[Terraform] Open HTTP to VPC"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
    description = "[Terraform] Open HTTPS to VPC"
  }

  ingress {
    from_port   = 32768
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
    description = "[Terraform] Open ECS ephemeral port range to VPC"
  }

  tags = merge(var.tags, map("Name", "private-web-app"))
}

resource "aws_security_group" "access_to_private_web_app" {
  name        = "access-to-private-web-app"
  description = "[Terraform] Allow VPC inbound traffic (80, 433)"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
    description = "[Terraform] Allow output to VPC HTTP"
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
    description = "[Terraform] Allow output to VPC HTTPS"
  }

  egress {
    from_port   = 32768
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
    description = "[Terraform] Allow output to VPC ECS ephemeral port range"
  }

  tags = merge(var.tags, map("Name", "access-to-private-web-app"))
}

resource "aws_security_group" "access_to_internet" {
  name        = "access-to-internet"
  description = "[Terraform] Allow output to Internet"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "[Terraform] Open to world (HTTP)"
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "[Terraform] Open to world (HTTPS)"
  }

  tags = merge(var.tags, map("Name", "access-to-internet"))
}
