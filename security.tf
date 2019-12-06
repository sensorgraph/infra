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
