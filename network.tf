provider "aws" {
    region      = "${var.aws_region}"
}

resource "aws_vpc" "main" {
    cidr_block  = "${var.vpc_cidr}"
    tags        = "${merge(var.tags, map("Name", "Main"))}"
}

resource "aws_internet_gateway" "public" {
    vpc_id  = "${aws_vpc.main.id}"
    tags    = "${merge(var.tags, map("Name", "Main"))}"
}

resource "aws_route_table" "public" {
    vpc_id     = "${aws_vpc.main.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.public.id}"
    }
    tags        = "${merge(var.tags, map("Name", "Main"))}"
}

resource "aws_route_table" "private" {
    vpc_id      = "${aws_vpc.main.id}"
    tags        = "${merge(var.tags, map("Name", "Main"))}"
}

resource "aws_subnet" "public" {
    count               = "${length(var.availability_zones)}"
    vpc_id              = "${aws_vpc.main.id}"
    cidr_block          = "${var.public_cidr[count.index]}"
    availability_zone   = "${var.availability_zones[count.index % length(var.availability_zones)]}"
    tags                = "${merge(var.tags, map("Name", "Main"))}"
}

resource "aws_subnet" "private" {
    count               = "${length(var.availability_zones)}"
    vpc_id              = "${aws_vpc.main.id}"
    cidr_block          = "${var.private_cidr[count.index]}"
    availability_zone   = "${var.availability_zones[count.index % length(var.availability_zones)]}"
    tags                = "${merge(var.tags, map("Name", "Main"))}"
}

resource "aws_route_table_association" "public" {
    count           = "${length(var.availability_zones)}"
    subnet_id       = "${element(aws_subnet.public.*.id, count.index)}"
    route_table_id  = "${aws_route_table.public.id}"
}


resource "aws_route_table_association" "private" {
    count           = "${length(var.availability_zones)}"
    subnet_id       = "${element(aws_subnet.private.*.id, count.index)}"
    route_table_id  = "${aws_route_table.private.id}"
}
