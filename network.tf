provider "aws" {
    region      = "${var.aws_region}"
}

resource "aws_vpc" "main" {
    cidr_block  = "${var.vpc_cidr}"
}

resource "aws_subnet" "public" {
    vpc_id     = "${aws_vpc.main.id}"
    cidr_block = "${var.public_cidr}"
  
}

resource "aws_subnet" "private" {
    vpc_id     = "${aws_vpc.main.id}"
    cidr_block = "${var.private_cidr}"
}
