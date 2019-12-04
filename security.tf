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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "[Terraform] Open to world"
  }

  tags = merge(var.tags, map("Name", "public-web-lb"))
}
